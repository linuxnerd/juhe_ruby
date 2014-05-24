# JuheRuby

[聚合](http://www.juhe.cn/)ruby api，目前完成了以下功能：

 - 常用快递查询

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
Juhe.express_app_key = "d85fa433fb8f30419dc1b3697b035b3d" # 注册时，聚合提供的app_key
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
Juhe.express_app_key = "d85fa433fb8f30419dc1b3697b035b3d"
Juhe::Express.refresh_companies
# or
Juhe::Express.refresh_companies(app_key: "d85fa433fb8f30419dc1b3697b035b3d")
```
