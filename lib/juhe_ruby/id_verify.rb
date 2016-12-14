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
      raise result["reason"] if result["error_code"] != 0
      result["result"]
    end
    
  end
end