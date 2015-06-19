require 'rails'

module Przelewy24
  class Configuration
    attr_accessor :merchant_id, :crc, :test_connection_params, :register_transaction_params, :return_url
    attr_reader :test_url, :register_url

    def initialize
      namespace = Rails.env=='production' ? 'secure' : 'sandbox'
      @test_url = "https://#{namespace}.przelewy24.pl/testConnection"
      @register_url =  "https://#{namespace}.przelewy24.pl/trnRegister"
      @return_url = nil
      @merchant_id = nil
      @crc = nil
      @test_connection_params = hash_of %w(merchant_id pos_id sign)
      @register_transaction_params = hash_of %w(session_id merchant_id pos_id amount currency description email country url_return api_version sign)
    end

    def default_transaction_options
      {:p24_merchant_id => @merchant_id,
       :p24_pos_id => @merchant_id,
       :p24_api_version => '3.2'}
    end

    private

    def hash_of(params)
      new_hash = Hash.new
      params.each do |k|
        new_hash[('p24_'+k).to_sym] = nil
      end
      new_hash
    end

  end
end