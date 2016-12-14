require "juhe_ruby/version"
require "juhe_ruby/express"
require "juhe_ruby/boxoffice"
require "juhe_ruby/idcard"
require "juhe_ruby/id_verify"

module Juhe
  URLS = {
    Express: "http://v.juhe.cn/exp",          # 常用快递查询
    Boxoffice: "http://v.juhe.cn/boxoffice",  # 电影票房
    IdCard: "http://apis.juhe.cn/idcard",     # 身份证查询
    IdVerify: "http://op.juhe.cn/idcard"      # 实名认证
  }

  class << self
    # Array of modules
    modules = Juhe.constants.map{ |el| Juhe.const_get(el) }.select{ |m| m.instance_of?(Module) }
    modules.each do |mod|
      if mod.to_s =~ /\AJuhe::(.*)/
        mod.const_set("BASE_URL", URLS[$1.to_sym])
        mod.module_eval do
          class << self
            attr_accessor :app_key
          end # class << self
        end # module_evale
      end # if
    end # modules.each
  end
end
