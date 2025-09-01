# frozen_string_literal: true

require "json"

def file_fixture(name)
  JSON.parse(File.read("./test/fixtures/#{name}"))
end
