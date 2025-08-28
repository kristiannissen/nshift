# frozen_string_literal: true

require "minitest/autorun"
require "logger"
require "nshift"

class TestNshift < Minitest::Test
  def setup
    @logger = Logger.new($stdout)
  end

  def test_say_hello
    assert_equal(Nshift.say_hello, "Hello Kitty")
  end

  def test_update_options_exception
    e = assert_raises(RuntimeError) do
      Nshift.update_options({ DoesNotExist: "Help" })
    end

    assert_equal(/Error/.match?(e.message), true)
  end
end
