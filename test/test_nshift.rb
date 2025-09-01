# frozen_string_literal: true

require "minitest/autorun"
require "logger"
require "time"
require "date"

require "nshift"
require "nshift/shipment"

require "fixture_helper"

class TestNshift < Minitest::Test
  def setup
    @logger = Logger.new($stdout)
    @options = { 'Labels': "PDF" }
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

  def test_shipment_typeerror_exception
    e = assert_raises(TypeError) do
      Nshift.submit_shipment(data: "hello", options: @options)
    end

    assert_equal(/data/.match?(e.message), true)
  end

  def test_shipment
    t = Time.now + (3600 * 24)                  # Future pickup date needed
    f = file_fixture("shipment_request.json")   # Returns a json fixture
    f["PickupDt"] = Date.parse(t.to_s)
    f["ActorCSID"] = ENV["ACTOR_ID"]
    f["InstallationID"] = ENV["INSTALLATION_ID"]

    assert_equal(Nshift.submit_shipment(data: f, options: @options).has_key?("ShpCSID"), true)
  end
end
