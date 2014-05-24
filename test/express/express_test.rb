require "test_helper"

class Juhe::ExpressTest < Test::Unit::TestCase
  def setup
    Juhe.app_key = "d85fa433fd8f30419dc1b3697b035b3d"
  end

  def test_app_key
    Juhe.app_key = "123456"
    assert_equal(Juhe.app_key, "123456")
  end

  def test_company_of_name
    assert_equal(Juhe::Express.company_code_of("申通"), "sto")
  end

  def test_search_without_app_key
    assert_equal(Juhe::Express.search("顺丰", "575677355677")["com"], "sf")
  end

  def test_search_with_app_key
    Juhe.app_key = ""
    result = Juhe::Express.search(
      "顺丰",
      "575677355677",
      app_key: "d85fa433fd8f30419dc1b3697b035b3d"
    )
    assert_equal(result["com"], "sf")
  end

  def test_only_the_first_query_company_uses_appkey
    first_time = Juhe::Express.company_code_of("申通") # => "sto"
    Juhe::app_key = "wrong app key"
    second_time = Juhe::Express.company_code_of("申通")
    assert_equal(first_time, second_time)
  end
end
