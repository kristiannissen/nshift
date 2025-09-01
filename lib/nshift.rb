# frozen_string_literal: true

require "logger"

require "nshift/shipment"

require_relative "nshift/version"

module Nshift
  extend self

  class Error < StandardError; end

  # Initialize
  @logger = Logger.new($stdout)
  @logger.level = Logger::DEBUG
  @options = { "Labels": "PDF" }
  # Option keys
  OPTION_KEYS = %(Labels TrackingURL TicketUserName
                  WorkstationID DropZoneLabelPrinterKey
                  DropZoneDocPrinterKey UseShippingRules
                  ServiceLevel RerunCSROnError Token
                  ReturnShipment PriceCalculation UseErrorLabels)
  # Update options
  def update_options(options)
    # Validate options keys
    options.each_key do |k|
      raise "Error" unless OPTION_KEYS.include?(k.to_s)
    end

    @options = options

    nil
  end

  def say_hello
    "Hello Kitty"
  end
end
