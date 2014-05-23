require "open-uri"
require "json"

module Juhe

  module ExpressCompany
    BASE_URL = "http://v.juhe.cn/exp/com"

    def self.included(base)
      base.extend ClassMethods
    end

    class << self
      attr_accessor :companies
    end

    module ClassMethods
      def company_code_of(company_name, options = nil)
        refresh_companies(options) if @companies.nil?

        @companies.each do |company|
          return company["no"] if company["com"] == company_name
        end
      end

      def refresh_companies(options)
        app_key = (options[:app_key] if options) || Juhe.app_key
        result = JSON.parse(open(BASE_URL+"?key="+app_key).read)
        raise result["reason"] if result["resultcode"] != "200"
        @companies = result["result"]
      end
    end
  end

  module Express
    include ExpressCompany

    BASE_URL = "http://v.juhe.cn/exp/index"

    def self.search(company_name, number, options = nil)
      app_key = (options[:app_key] if options) || Juhe.app_key
      url = BASE_URL \
            + "?key=" \
            + app_key \
            + "&no=" + number \
            + "&com=" + company_code_of(company_name, options)

      result = JSON.parse(open(url).read)
      raise result["reason"] if result["resultcode"] != "200"
      result["result"]
    end
  end
end
