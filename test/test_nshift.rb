# frozen_string_literal: true

require "minitest/autorun"
require "logger"
require "time"
require "date"

require "nshift"

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
    e = assert_raises(ArgumentError) do
      Nshift.update_options({ DoesNotExist: "Help" })
    end

    assert_equal(/DoesNotExist/.match?(e.message), true)
  end

  def test_shipment_typeerror_exception
    e = assert_raises(ArgumentError) do
      Nshift.submit_shipment(data: "hello", options: @options)
    end

    assert_equal(/Data/.match?(e.message), true)
  end

  def test_shipment
    skip "Not needed for now"
    t = Time.now + (3600 * 24)                  # Future pickup date needed
    f = file_fixture("shipment_request.json")   # Returns a json fixture
    f["PickupDt"] = Date.parse(t.to_s)
    f["ActorCSID"] = ENV["ACTOR_ID"]
    f["InstallationID"] = ENV["INSTALLATION_ID"]

    s = Nshift.submit_shipment(data: f, options: @options)
    assert_equal(s.has_key?("ShpCSID"), true)
  end

  def test_get_stacks
    s = Nshift.get_stacks

    assert_equal(s.has_key?("Carriers"), true)
  end

  def test_transmit_stack_error
    e = assert_raises(ArgumentError) do
      Nshift.transmit_stack()
    end

    assert_equal(e.message.match?(/stack_id/), true)
  end

  def test_transmit_stack
    s = Nshift.transmit_stack(stack_id: 25632)

    assert_equal(s.has_key?("BatchCSID"), true)
  end

  def test_get_batch_list
    b = Nshift.get_batch_list(count: 5)

    assert(b.has_key?("Count"))
  end

  def test_get_batch_shipments
    b = Nshift.get_batch_shipments(batch_csid: 104921375)

    asserti_true(b.has_key?("Shipments"), true)
  end

  def test_get_batch_shipments_error
    e = assert_raises(RuntimeError) do
      Nshift.get_batch_shipments(batch_csid: 42)
    end

    assert_equal(e.message.match?(/BatchCSID/), true)
  end
end
