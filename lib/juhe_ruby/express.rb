require "open-uri"
require "json"

module Juhe
  module Express
    BASE_URL = "http://v.juhe.cn/exp"

    class << self
      attr_accessor :companies
    end

    def self.search(company_name, number, options = nil)
      app_key = (options[:app_key] if options) || Juhe.express_app_key
      url = BASE_URL \
            + "/index?key=" \
            + app_key \
            + "&no=" + number \
            + "&com=" + company_code_of(company_name, options)

      result = JSON.parse(open(url).read)
      raise result["reason"] if result["resultcode"] != "200"
      result["result"]
    end

    def self.company_code_of(company_name, options = nil)
      refresh_companies(options) if @companies.nil?

      @companies.each do |company|
        return company["no"] if company["com"] == company_name
      end
    end

    def self.refresh_companies(options)
      app_key = (options[:app_key] if options) || Juhe.express_app_key
      result = JSON.parse(open(BASE_URL+"/com?key="+app_key).read)
      raise result["reason"] if result["resultcode"] != "200"
      @companies = result["result"]
    end
  end
end
