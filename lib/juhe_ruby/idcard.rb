require "open-uri"
require "json"

module Juhe
  module IdCard

    def self.search(cardno, options=nil)
      app_key = (options[:app_key] if options) || Juhe::IdCard.app_key

      url = BASE_URL +
            "/index?key=" + app_key +
            "&cardno=" + cardno

      result = JSON.parse(open(url).read)
      raise result["reason"] if result["resultcode"] != "200"
      result["result"]
    end
    
  end
end