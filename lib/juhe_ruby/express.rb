require "open-uri"
require "json"

module Juhe
  module Express
    include Company
    URL = "http://v.juhe.cn/exp/index"

    def self.search(company_name, options)
    end
  end

  module Company
    URL = "http://v.juhe.cn/exp/com"

    def self.express_companies
      result = JSON.parse(open(URL).read)
      raise result[:reason] if result[:resultcode] != "200"
      result[:result]
    end

    def self.company_code_of(company_name)
      express_companies.each do |company|
        return company[:no] if company[:com] == company_name
      end
    end
  end
end