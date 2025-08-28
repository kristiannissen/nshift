# frozen_string_literal: true

module Nshift
  module_function

  # https://helpcenter.nshift.com/hc/en-us/articles/360001457853-Methods#submitshipment
  def submit_shipment(data:, options:)
    @logger.debug([data, options])

    "Hello"
  end
end
