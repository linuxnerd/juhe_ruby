require "open-uri"
require "json"

module Juhe
  module Boxoffice

    def self.latest(area, options = nil)
      app_key = (options[:app_key] if options) || Juhe::Boxoffice.app_key

      url = BASE_URL \
            + "/rank?key=" + app_key \
            + "&area=" + area
      result = JSON.parse(open(url).read)
      raise result["reason"] if result["resultcode"] != "200"
      result["result"]
    end


    def self.wp(options = nil)
      app_key = (options[:app_key] if options) || Juhe::Boxoffice.app_key

      url = BASE_URL \
            + "/wp?key=" + app_key
      result = JSON.parse(open(url).read)
      raise result["reason"] if result["resultcode"] != "200"
      result["result"]
    end

  end
end
