use db;

drop table moperson;

create table moperson (
    name varchar(100) not null primary key, 
    github varchar(100), 
    wechat varchar(100),
    dept varchar(100),
    team varchar(100),
    city varchar(100),
    xxxx varchar(1000)
);

insert into moperson values 
('Su Dong', 'aressu1985', null, 'test', 'test', 'NanJing', 'test test test'),
('Tian Feng', 'fengttt', null, 'test', 'test', 'Fremont', 'tttest'),
('Wang Long', null, null, 'test', 'test', 'Fremont', 'What is github?'),
('Tian YaHui', 'tianyahui-python', null, 'test', 'test', 'ShangHai', 'real man write python'),

('Zuo XingGuang', 'goodMan-code', null, 'test', 'test', 'ShangHai', 'good monkey code too'),
('He Ni', 'heni02', null, 'test', 'test', 'ShangHai', 'hi ni ni hi'),
('Zhang Xiao', 'domingozhang', null, 'product', 'product', 'BeiJing', 'radio talkshow'),
('Deng Nan', 'dengn', 'product', null, 'product', 'ShangHai', 'type faster!'),
('Wang ZiNang', 'lacriosaprinz', null, 'product', 'product', 'ShangHai', 'type faster!'),
('Li Song', 'LiSong0214',null,  'product', 'product', 'ShangHai', '02141024'),
('Shi MingHua', 'florashi181', null, 'product', 'product', 'ShangHai', 'the flower girl'),
('Xu Peng', 'XuPeng-SH',null,  'R&D', 'storage', 'ShangHai', 'The chubby one'),
('Zhou ZiLong', 'zzl200012', null, 'R&D', 'storage', 'ShangHai', null),
('Shen JiangWei', 'LeftHandCold', null, 'R&D', 'storage', 'ShangHai', 'But my right hand is HOT!'),
('Jian XinMeng', 'jiangxinmeng1', null, 'R&D', 'storage', 'ShangHai', 'coding now'),
('Han Feng', 'aptend',null,  'R&D','storage',  'ShangHai', 'apt upgrade'),
('Luo Fei', 'triump2020',null,  'R&D','storage',  'Beijing', 'Trump 2024'),
('Zhang Xu', 'zhangxu19830126', null, 'R&D','distributed system',  'NanJing', 'Born in 1983'),
('Li YueSheng', 'reusee',null,  'R&D', 'distributed system', 'GuangZhou', 'reuse and recycle'),
('Cui GuoKe', 'cnutshell', null, 'R&D', 'distributed system', 'BeiJing', 'oh boy our distributed sys team is really distributed'),
('Wei ZiRan', 'w-zr', null, 'R&D', 'distributed system', 'ShangHai', 'I can''t believe it, totally geo replicated'),
('Mo Chen', 'nnsgmsone',null,  'R&D', 'engine', 'SuZhou', 'totally invested in doge coin'),
('Long Ran', 'aunjgr', null, 'R&D', 'engine', 'ShangHai', 'long long long long long long long long long ...'),
('Peng Zhen', 'daviszhen',null,  'R&D', 'engine', 'ShangHai', 'David Peng Peng Peng Peng'),
('Wang Jian', 'jianwang0214', null, 'R&D', 'engine', 'ShangHai', 'Juan Wang'),
('Chen MingSong', 'm-schen',null,  'R&D', 'engine', 'ShangHai', 'cms'),
('Lin JunHong', 'iamlinjunhong',null,  'R&D', 'engine', 'ShangHai', 'we know who you are'),
('Wu XiLiang', 'qingxinhome', null, 'R&D', 'engine', 'BeiJing', 'Light!'),
('Ou YuanNing', 'ouyuanning',null,  'R&D', 'engine', 'XiaMen', 'Ou, XiaMen, Really?'),
('Wu XinXuan', 'dongdongyang33',null,  'R&D', 'engine', 'ShangHai', 'Why sheep?'),
('Ma ZiJie', 'bbbearxyz', 'R&D', null, 'engine', null, 'Horse and Bear'),
('Tan BoYu', 'JackTan25', 'R&D',null,  'engine', null, 'Jack'),
('Ou JinSai', 'jensenojs', 'R&D', null, 'engine', null, 'Euro Championship'),
('Li ChangLiang', 'mooleetzi',null,  'R&D', 'engine', null, 'const light'),
('Jia JieJie', 'guguducken',null,  'R&D', null, null, 'JJJ'),
('Qin ZhuQi', 'sukki37',null,  'R&D', 'cloud', null, 'catcat cat girl'),
('Jin QinHui', 'jqh9804',null,  'R&D', 'cloud', 'ChangSha', 'Hui dude'),
('Xie ZeXiong', 'xzxiong', null, 'R&D', 'cloud', 'ShengZhen', 'The bear'),
('Wu YeLei', 'aylei',null,  'R&D', 'cloud', 'HangZhou', 'cloudy'),
('Xu Heng', 'xuoutput',null,  'R&D', 'cloud', 'ShangHai', 'lots of output'),
('Wang Lei', 'wanglei4687', null, 'R&D', 'cloud', 'ShangHai', 'the 4687th wang lei'),
('Zhang HaiLong', 'DanielZhangQD', null, 'R&D', 'cloud', 'QingDao', 'Beer!'),

('Tian Xiangyu', 'VincentTian0001', null, 'test', 'test', 'ShenZhen', 'keep it simple')

;

select count(*) from moperson;
select team, count(*) from moperson group by team order by count(*);











