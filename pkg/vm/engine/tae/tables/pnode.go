// Copyright 2021 Matrix Origin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package tables

import (
	"bytes"

	"github.com/RoaringBitmap/roaring"
	"github.com/matrixorigin/matrixone/pkg/common/moerr"
	"github.com/matrixorigin/matrixone/pkg/vm/engine/tae/common"
	"github.com/matrixorigin/matrixone/pkg/vm/engine/tae/containers"
	"github.com/matrixorigin/matrixone/pkg/vm/engine/tae/tables/indexwrapper"
)

type persistedNode struct {
	common.RefHelper
	block   *baseBlock
	pkIndex indexwrapper.Index
	indexes map[int]indexwrapper.Index
}

func newPersistedNode(block *baseBlock) *persistedNode {
	node := &persistedNode{
		block: block,
	}
	node.OnZeroCB = node.close
	if block.meta.HasPersistedData() {
		node.init()
	}
	return node
}

func (node *persistedNode) close() {
	for i, index := range node.indexes {
		index.Close()
		node.indexes[i] = nil
	}
	node.indexes = nil
}

func (node *persistedNode) init() {
	node.indexes = make(map[int]indexwrapper.Index)
	schema := node.block.meta.GetSchema()
	pkIdx := -1
	if schema.HasPK() {
		pkIdx = schema.GetSingleSortKeyIdx()
	}
	for i := range schema.ColDefs {
		index := indexwrapper.NewImmutableIndex()
		if err := index.ReadFrom(
			node.block.bufMgr,
			node.block.fs,
			node.block.meta.AsCommonID(),
			node.block.meta.GetMetaLoc(),
			schema.ColDefs[i]); err != nil {
			panic(err)
		}
		node.indexes[i] = index
		if i == pkIdx {
			node.pkIndex = index
		}
	}
}

func (node *persistedNode) Pin() *common.PinnedItem[*persistedNode] {
	node.Ref()
	return &common.PinnedItem[*persistedNode]{
		Val: node,
	}
}

func (node *persistedNode) Rows() uint32 {
	location := node.block.meta.GetMetaLoc()
	return uint32(ReadPersistedBlockRow(location))
}

func (node *persistedNode) BatchDedup(
	keys containers.Vector,
	skipFn func(row uint32) error) (sels *roaring.Bitmap, err error) {
	return node.pkIndex.BatchDedup(keys, skipFn)
}

func (node *persistedNode) Dedup(key any) (err error) {
	return node.pkIndex.Dedup(key, nil)
}

func (node *persistedNode) ContainsKey(key any) (ok bool, err error) {
	if err = node.pkIndex.Dedup(key, nil); err == nil {
		return
	}
	if !moerr.IsMoErrCode(err, moerr.OkExpectedPossibleDup) {
		return
	}
	ok = true
	err = nil
	return
}

func (node *persistedNode) GetColumnDataWindow(
	from uint32,
	to uint32,
	colIdx int,
	buffer *bytes.Buffer,
) (vec containers.Vector, err error) {
	var data containers.Vector
	if data, err = node.block.LoadPersistedColumnData(
		colIdx,
		buffer); err != nil {
		return
	}
	if to-from == uint32(data.Length()) {
		vec = data
	} else {
		vec = data.CloneWindow(int(from), int(to-from), common.DefaultAllocator)
		data.Close()
	}
	return
}

func (node *persistedNode) GetDataWindow(
	from, to uint32) (bat *containers.Batch, err error) {
	data, err := node.block.LoadPersistedData()
	if err != nil {
		return
	}

	if to-from == uint32(data.Length()) {
		bat = data
	} else {
		bat = data.CloneWindow(int(from), int(to-from), common.DefaultAllocator)
		data.Close()
	}
	return
}
