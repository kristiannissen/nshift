# frozen_string_literal: true
#
require "uri"
require "net/http"
require "json"
require "dotenv/load"

module Nshift
  extend self

  def post_form(cmd:, data:, options:)
    uri = URI(ENV["API_ENDPOINT"])
    req = Net::HTTP::Post.new(uri, initheader = { "Content-Type" => "application/x-www-form-urlencoded" })
    req.set_form_data("actor" => ENV["ACTOR_ID"], "key" => ENV["API_KEY"],
                      "command" => cmd, "data" => data.to_json,
                      "options" => options.to_json)

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess
      # OK
      JSON.parse(res.body)
    else
      # Not OK
      @logger.debug([res.body, Net::HTTP::Response::Status])
      raise StandardError, "Error code #{Net::HTTP::Response::Status}"
    end
  end
end
