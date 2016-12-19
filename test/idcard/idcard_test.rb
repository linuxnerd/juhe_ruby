require "test_helper"

class Juhe::IdCardTest < Minitest::Test
  def setup
    Juhe::IdCard.app_key = "54be350eb2fdefe5a9a087bf6669cc68"
  end

  def test_app_key
    Juhe::IdCard.app_key = "123456"
    assert_equal(Juhe::IdCard.app_key, "123456")
  end

  def test_search_without_app_key
    assert_equal(Juhe::IdCard.search("310108198701142032")["area"], "上海市闸北区")
  end

  def test_search_with_app_key
    Juhe::IdCard.app_key = ""
    result = Juhe::IdCard.search(
      "310108198701142032",
      app_key: "54be350eb2fdefe5a9a087bf6669cc68"
    )
    assert_equal(result["area"], "上海市闸北区")
  end
end