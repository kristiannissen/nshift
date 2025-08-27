require "minitest/autorun"
require "logger"
require "nshift"

class TestNshift < Minitest::Test
  def setup
    @logger = Logger.new($stdout)
  end

  def test_say_hello
    assert_equal(Nshift.say_hello, "hello Kitty")
  end
end
