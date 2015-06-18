require 'rails'

module Przelewy24
  class Configuration
    attr_accessor :merchant_id
    attr_accessor :crc
    attr_reader :test_url
    attr_reader :status_url

    def initialize
      namespace = Rails.env=='production' ? 'secure' : 'sandbox'
      @test_url = "https://#{namespace}.przelewy24.pl/testConnection"
      @status_url = "https://#{namespace}.przelewy24.pl/testConnection"
      @merchant_id = nil
      @crc = nil
    end

  end
end