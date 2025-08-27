# frozen_string_literal: true

require_relative "nshift/version"

module Nshift
  extend self

  class Error < StandardError; end
  # Your code goes here...

  def say_hello
    "hello Kitty"
  end
end
