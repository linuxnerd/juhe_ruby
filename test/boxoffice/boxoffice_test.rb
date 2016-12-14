require "test_helper.rb"

class Juhe::BoxofficeTest < Minitest::Test
  def setup
    Juhe::Boxoffice.app_key = "8b5f6d4adb46123938ebad000ca09300"
  end

  def test_app_key
    Juhe::Boxoffice.app_key = "123456"
    assert_equal(Juhe::Boxoffice.app_key, "123456")
  end

  def test_latest_without_app_key
    assert_not_nil(Juhe::Boxoffice.latest("hk").first["rid"])
  end

  def test_latest_with_app_key
    Juhe::Boxoffice.app_key = ""
    result = Juhe::Boxoffice.latest("hk", app_key: "8b5f6d4adb46123938ebad000ca09300")
    assert_not_nil(result.first["rid"])
  end

  def test_wp_without_app_key
    assert_not_nil(Juhe::Boxoffice.wp.first["name"])
  end

  def test_wp_with_app_key
    Juhe::Boxoffice.app_key = ""
    result = Juhe::Boxoffice.wp(app_key: "8b5f6d4adb46123938ebad000ca09300")
    assert_not_nil(result.first["name"])
  end
end
