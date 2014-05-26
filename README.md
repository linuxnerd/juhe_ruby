# JuheRuby

[聚合](http://www.juhe.cn/)ruby api，目前完成了以下功能：

 - 常用快递查询
 - 电影票房

## 安装

在Gemfile里加入这行:
```ruby
gem 'juhe_ruby'
```

然后执行:
```ruby
$ bundle
```
或者自行安装:
```ruby
$ gem install juhe_ruby
```
## 用法

### 常用快递查询
目前支持的快递公司，`%w[顺丰 申通 圆通 韵达 天天 EMS 中通 汇通]`详细的请在[聚合页面](http://www.juhe.cn/docs/api/id/43/aid/103)上查看。
api在第一次查询时也会调用快递公司查询接口。

具体用法设置app_key，然后进行查询：
```ruby
Juhe::Express.app_key = "d85fa433fb8f30419dc1b3697b035b3d" # 注册时，聚合提供的app_key
Juhe::Express.search("顺丰", "575677355677")
```
或者直接将app_key作为参数:
```ruby
Juhe::Express.search("顺丰", "575677355677", app_key: "d85fa433fb8f30419dc1b3697b035b3d")
```
返回Hash数组：
```ruby
[
  {
    "datetime":"2013-06-25 10:44:05", # 时间
    "remark":"已收件", # 描述
    "zone":"台州市" # 区域
  },
  {
  "datetime":"2013-06-25 11:05:21",
  "remark":"快件在 台州 ,准备送往下一站 台州集散中心 ",
  "zone":"台州市"
  },
  {
  "datetime":"2013-06-25 20:36:02",
  "remark":"快件在 台州集散中心 ,准备送往下一站 台州集散中心 ",
  "zone":"台州市"
  },
  {
  "datetime":"2013-06-25 21:17:36",
  "remark":"快件在 台州集散中心 ,准备送往下一站 杭州集散中心 ",
  "zone":"台州市"
  },
  {
  "datetime":"2013-06-26 12:20:00",
  "remark":"快件在 杭州集散中心 ,准备送往下一站 西安集散中心 ",
  "zone":"杭州市"
  },
  {
  "datetime":"2013-06-27 05:48:42",
  "remark":"快件在 西安集散中心 ,准备送往下一站 西安 ",
  "zone":"西安市/咸阳市"
  },
  {
  "datetime":"2013-06-27 08:03:03",
  "remark":"正在派件..",
  "zone":"西安市/咸阳市"
  },
  {
  "datetime":"2013-06-27 08:51:33",
  "remark":"派件已签收",
  "zone":"西安市/咸阳市"
  },
  {
  "datetime":"2013-06-27 08:51",
  "remark":"签收人是：已签收 ",
  "zone":"西安市/咸阳市"
  }
]
```
程序第一次运行会获取快递公司列表，如果想手动刷新快递公司信息：
```ruby
Juhe::Express.app_key = "d85fa433fb8f30419dc1b3697b035b3d"
Juhe::Express.refresh_companies
# or
Juhe::Express.refresh_companies(app_key: "d85fa433fb8f30419dc1b3697b035b3d")
```

### 电影票房
#### 最新票房榜
票房榜的区域,CN-内地，US-北美，HK-香港。
示例：
```ruby
Juhe::Boxoffice.app_key = "d85fa433fd8430419dc1b3697b035b3d"
Juhe::Boxoffice.latest("HK") # 香港最新票房榜
# 或者app_key直接作为参数
Juhe::Boxoffice.latest("HK", app_key: "d85fa433fd8430419dc1b3697b035b3d") # 香港最新票房榜
```
返回Hash数组：
```ruby
[
  {
    "rid":"1",
    "name":"中国合伙人",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥20900万",
    "tboxoffice":"￥31700万"
  },
  {
    "rid":"2",
    "name":"钢铁侠3",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥4480万",
    "tboxoffice":"￥74480万"
  },
  {
    "rid":"3",
    "name":"疯狂原始人",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥3050万",
    "tboxoffice":"￥35240万"
  },
  {
    "rid":"4",
    "name":"遗落战境",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥2680万",
    "tboxoffice":"￥13980万"
  },
  {
    "rid":"5",
    "name":"致我们终将逝去的青春",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥2290万",
    "tboxoffice":"￥71206万"
  },
  {
    "rid":"6",
    "name":"圣诞玫瑰(new)",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥1390万",
    "tboxoffice":"￥1390万"
  },
  {
    "rid":"7",
    "name":"一路狂奔(new)",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥350万",
    "tboxoffice":"￥350万"
  },
  {
    "rid":"8",
    "name":"被解救的姜戈",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥309万",
    "tboxoffice":"￥1664万"
  },
  {
    "rid":"9",
    "name":"临终囧事",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥285万",
    "tboxoffice":"￥660万"
  },
  {
    "rid":"10",
    "name":"西柏坡2：王二小",
    "wk":"2013.5.20--2013.5.26（单位：人民币）",
    "wboxoffice":"￥25万",
    "tboxoffice":"￥45万"
  }
]
```

#### 网票票房
示例：
```ruby
Juhe::Boxoffice.app_key = "d85fa433fd8430419dc1b3697b035b3d"
Juhe::Boxoffice.wp # 网票票房
# 或者app_key直接作为参数
Juhe::Boxoffice.wp(app_key: "d85fa433fd8430419dc1b3697b035b3d") # 网票票房
```
返回Hash数组：
```ruby
[
  {
    "name": "惊天危机（数字）", /*影片名称*/
    "totals": "2262", /*总场次*/
    "statistics": "1111", /*统计场次*/
    "averaging": "27",  /*场均*/
    "attendance": "15%",  /*上座率*/
    "people": "29999",  /*人次*/
    "fare": "39", /*票价（元）*/
    "boxoffice": "1164731"  /*票房（元）*/
  },
  {
    "name": "大明猩（数字3D）",
    "totals": "1278",
    "statistics": "613",
    "averaging": "21",
    "attendance": "13%",
    "people": "12726",
    "fare": "48",
    "boxoffice": "607759"
  },
  {
    "name": "重返地球（数字）",
    "totals": "1343",
    "statistics": "579",
    "averaging": "14",
    "attendance": "10%",
    "people": "8068",
    "fare": "39",
    "boxoffice": "311146"
  },
  {
    "name": "笔仙Ⅱ",
    "totals": "747",
    "statistics": "313",
    "averaging": "21",
    "attendance": "19%",
    "people": "6672",
    "fare": "37",
    "boxoffice": "243868"
  },
  {
    "name": "赛尔号3战神联盟（数字3D）",
    "totals": "370",
    "statistics": "283",
    "averaging": "18",
    "attendance": "14%",
    "people": "5054",
    "fare": "45",
    "boxoffice": "226842"
  },
  {
    "name": "天台爱情",
    "totals": "633",
    "statistics": "311",
    "averaging": "15",
    "attendance": "12%",
    "people": "4546",
    "fare": "39",
    "boxoffice": "179300"
  },
  {
    "name": "盲探",
    "totals": "437",
    "statistics": "203",
    "averaging": "14",
    "attendance": "11%",
    "people": "2846",
    "fare": "39",
    "boxoffice": "110928"
  },
  {
    "name": "火焰山历险记",
    "totals": "197",
    "statistics": "141",
    "averaging": "10",
    "attendance": "9%",
    "people": "1346",
    "fare": "34",
    "boxoffice": "45422"
  },
  {
    "name": "小时代",
    "totals": "132",
    "statistics": "75",
    "averaging": "14",
    "attendance": "11%",
    "people": "1019",
    "fare": "37",
    "boxoffice": "37873"
  },
  {
    "name": "追踪长尾豹马修（数字）",
    "totals": "131",
    "statistics": "74",
    "averaging": "14",
    "attendance": "13%",
    "people": "1023",
    "fare": "35",
    "boxoffice": "35670"
  },
  {
    "name": "终极大冒险（数字3D）",
    "totals": "137",
    "statistics": "86",
    "averaging": "9",
    "attendance": "7%",
    "people": "772",
    "fare": "43",
    "boxoffice": "33118"
  },
  {
    "name": "萨米大冒险2（数字3D）",
    "totals": "10",
    "statistics": "5",
    "averaging": "108",
    "attendance": "62%",
    "people": "538",
    "fare": "43",
    "boxoffice": "22901"
  },
  {
    "name": "早见，晚爱",
    "totals": "91",
    "statistics": "35",
    "averaging": "14",
    "attendance": "13%",
    "people": "482",
    "fare": "39",
    "boxoffice": "18940"
  },
  {
    "name": "天机——富春山居图",
    "totals": "4",
    "statistics": "4",
    "averaging": "132",
    "attendance": "79%",
    "people": "528",
    "fare": "34",
    "boxoffice": "18200"
  },
  {
    "name": "开心超人",
    "totals": "17",
    "statistics": "14",
    "averaging": "14",
    "attendance": "12%",
    "people": "191",
    "fare": "33",
    "boxoffice": "6332"
  },
  {
    "name": "校花诡异事件",
    "totals": "24",
    "statistics": "11",
    "averaging": "12",
    "attendance": "10%",
    "people": "128",
    "fare": "41",
    "boxoffice": "5275"
  },
  {
    "name": "功夫侠",
    "totals": "31",
    "statistics": "13",
    "averaging": "10",
    "attendance": "8%",
    "people": "124",
    "fare": "34",
    "boxoffice": "4242"
  },
  {
    "name": "不二神探",
    "totals": "7",
    "statistics": "3",
    "averaging": "17",
    "attendance": "22%",
    "people": "52",
    "fare": "28",
    "boxoffice": "1456"
  },
  {
    "name": "初恋未满",
    "totals": "10",
    "statistics": "2",
    "averaging": "17",
    "attendance": "27%",
    "people": "33",
    "fare": "23",
    "boxoffice": "759"
  },
  {
    "name": "赤警威龙（数字）",
    "totals": "8",
    "statistics": "1",
    "averaging": "3",
    "attendance": "9%",
    "people": "3",
    "fare": "27",
    "boxoffice": "81"
  },
  {
    "name": "太极侠",
    "totals": "2",
    "statistics": "0",
    "averaging": "0",
    "attendance": "0%",
    "people": "0",
    "fare": "0",
    "boxoffice": "0"
  },
  {
    "name": "咒·丝",
    "totals": "2",
    "statistics": "0",
    "averaging": "0",
    "attendance": "0%",
    "people": "0",
    "fare": "0",
    "boxoffice": "0"
  },
  {
    "name": "超人：钢铁之躯（数字3D）",
    "totals": "1",
    "statistics": "0",
    "averaging": "0",
    "attendance": "0%",
    "people": "0",
    "fare": "0",
    "boxoffice": "0"
  }
]
```