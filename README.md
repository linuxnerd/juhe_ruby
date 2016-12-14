# JuheRuby
[![Gem Version](https://badge.fury.io/rb/juhe_ruby.svg)](http://badge.fury.io/rb/juhe_ruby)

[聚合](http://www.juhe.cn/)ruby api，目前完成了以下功能：

 - 身份证实名认证
 - 身份证查询
 - 常用快递查询
 - 电影票房

## 安装

在Gemfile里加入这行:
```ruby
gem 'juhe_ruby'
```

然后执行:
```ruby
$ bundle install
```
或者自行安装:
```ruby
$ gem install juhe_ruby
```
## 用法
先创建文件`config/initializers/juhe_ruby_config.rb`设置各接口的app_key
```ruby
Juhe::IdVerify.app_key = "54be350eb2fdefe5a9a087bf6669cc68"
Juhe::IdCard.app_key = "54be350eb2fdefe5a9a087bf6669cc68"
Juhe::Express.app_key = "d85fa433fb8f30419dc1b3697b035b3d"
Juhe::Boxoffice.app_key = "d85fa433fd8430419dc1b3697b035b3d"
```

### 身份证实名认证
如果事先设置了app_key，就直接进行查询认证：
```ruby
Juhe::IdVerify.search("32010819820114203X","王大锤")
```
或者直接将app_key作为参数：
```ruby
Juhe::IdVerify.search("32010819820114203X","王大锤", app_key: "54be350eb2fdefe5a9a087bf6669cc68")
```
应答后返回的json格式，如果请求失败会抛出异常：
```ruby
{
  "realname": "董好帅", # 真实姓名
  "idcard": "330329199001020012", # 身份证号码
  "res": 1 # 1：匹配 2：不匹配
}
```
获取应答结果的方式：
```ruby
result=Juhe::IdVerify.search("32010819820114203X","王大锤")
if(result["res"] == 0)
  puts "实名认证匹配通过"
else if(result["res"] == 1)
  puts "实名认证匹配未通过"
end
```

### 常用快递查询
目前支持的快递公司，`%w[顺丰 申通 圆通 韵达 天天 EMS 中通 汇通]`详细的请在[聚合页面](http://www.juhe.cn/docs/api/id/43/aid/103)上查看。
api在第一次查询时也会调用快递公司查询接口。

如果事先设置了app_key，就直接进行查询认证：
```ruby
Juhe::Express.search("顺丰", "575677355677")
```
或者直接将app_key作为参数：
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
Juhe::Express.refresh_companies
# or
Juhe::Express.refresh_companies(app_key: "d85fa433fb8f30419dc1b3697b035b3d")
```

### 电影票房
#### 最新票房榜
票房榜的区域,CN-内地，US-北美，HK-香港。
示例：
```ruby
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
Juhe::Boxoffice.wp # 网票票房
# 或者app_key直接作为参数
Juhe::Boxoffice.wp(app_key: "d85fa433fd8430419dc1b3697b035b3d") # 网票票房
```
返回Hash数组：
```ruby
[
  {
    "name": "惊天危机（数字）", # 影片名称
    "totals": "2262", # 总场次
    "statistics": "1111", # 统计场次
    "averaging": "27",  # 场均
    "attendance": "15%",  # 上座率
    "people": "29999",  # 人次
    "fare": "39", # 票价（元）
    "boxoffice": "1164731"  # 票房（元）
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
  }
]
```
