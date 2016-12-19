require "open-uri"
require "json"

module Juhe
  module IdVerify

    def self.search(cardno, name, options=nil)
      app_key = (options[:app_key] if options) || Juhe::IdVerify.app_key

      url = BASE_URL +
            "/index?key=" + app_key +
            "&idcard=" + cardno +
            "&realname=" + URI::encode(name)

      result = JSON.parse(open(url).read)

      # 210301 身份证不存在，210304 身份证不合法
      if(result["error_code"] == 210301 or result["error_code"] == 210304)
        result["error_code"] = 0
        result["result"] = {
          "realname"=> name,
          "idcard"=> cardno,
          "res"=> 2
        }
      end

      raise result["reason"] if result["error_code"] != 0
      result["result"]
    end
    
  end
end