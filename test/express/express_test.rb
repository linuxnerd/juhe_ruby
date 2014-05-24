require "test_helper"

class Juhe::ExpressTest < Test::Unit::TestCase
  def setup
    Juhe::Express.app_key = "d85fa433fd8f30419dc1b3697b035b3d"
  end

  def test_app_key
    Juhe::Express.app_key = "123456"
    assert_equal(Juhe::Express.app_key, "123456")
  end

  def test_company_of_name
    assert_equal(Juhe::Express.company_code_of("申通"), "sto")
  end

  def test_search_without_app_key
    assert_equal(Juhe::Express.search("顺丰", "575677355677")["com"], "sf")
  end

  def test_search_with_app_key
    Juhe::Express.app_key = ""
    result = Juhe::Express.search(
      "顺丰",
      "575677355677",
      app_key: "d85fa433fd8f30419dc1b3697b035b3d"
    )
    assert_equal(result["com"], "sf")
  end

  def test_only_the_first_company_query_uses_api
    first_time = Juhe::Express.company_code_of("申通") # => "sto"
    Juhe::Express.app_key = "wrong app key"
    second_time = Juhe::Express.company_code_of("申通")
    assert_equal(first_time, second_time)
  end
end
