require 'minitest/autorun'
require 'doddle'
require "erb"
require "yaml"

module Doddle::Test

  module Credentials

    CREDS_DATA = ERB.new File.new("test/credentials.yml").read

    def creds
      @@creds_hash ||= YAML.load( CREDS_DATA.result(binding) ).transform_keys!(&:to_sym)

      return @@creds_hash
    end

  end

end
