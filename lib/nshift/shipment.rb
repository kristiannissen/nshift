# frozen_string_literal: true
require "nshift/request"

module Nshift
  extend self

  # https://helpcenter.nshift.com/hc/en-us/articles/360001457853-Methods#submitshipment
  # Accepts a hash
  def submit_shipment(data:, options:)
    raise ArgumentError, "Data must be hash, got #{data.class}" unless data.is_a?(Hash)

    res = post_form(cmd: "SubmitShipment", data: data, options: options)
    raise RuntimeError, res unless res.has_key?("ShpCSID")

    res
  end
end
