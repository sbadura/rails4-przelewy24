require 'rails'

module Przelewy24
  class Configuration
    attr_accessor :merchant_id, :crc, :url_return, :url_status
    attr_accessor :test_connection_params, :register_transaction_params, :confirm_transaction_params
    attr_reader :test_url, :register_url, :request_url, :confirm_transaction_url

    def initialize(sandbox = false)
      @merchant_id = nil
      @crc = nil
      namespace = sandbox ? 'sandbox' : 'secure'
      @test_url = "https://#{namespace}.przelewy24.pl/testConnection"
      @register_url =  "https://#{namespace}.przelewy24.pl/trnRegister"
      @request_url = "https://#{namespace}.przelewy24.pl/trnRequest/"
      @confirm_transaction_url = "https://#{namespace}.przelewy24.pl/trnVerify"
      @url_return = nil
      @url_status = nil
      @test_connection_params = hash_of %w(merchant_id pos_id sign)
      @register_transaction_params = hash_of %w(session_id merchant_id pos_id amount currency description email country url_return url_status api_version sign)
      @confirm_transaction_params = hash_of %w(merchant_id pos_id session_id amount currency order_id sign)
      @api_version = '3.2'
    end

    def default_transaction_options
      out = {}
      self.instance_values.each do |o,v|
        out[o.to_sym] = v
      end
      out
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
