require 'httparty'
require 'json'

module Przelewy24
  class Transaction
    attr_accessor :options
    
    def initialize(options = {})
      @conf = Przelewy24.config
      @options = {:pos_id => @conf.merchant_id}.merge(options)
    end

    def test_connection
      response = HTTParty.post @conf.test_url, body: test_params
      response = Rack::Utils.parse_nested_query response.parsed_response
      response['error'] == '0' ? true : response
    end

  
    private

    def test_params
      pos = @options[:pos_id]
      {
        :p24_merchant_id => @conf.merchant_id,
        :p24_pos_id => pos,
        :p24_sign => sign([pos, @conf.crc])
      }
    end

    def sign(params = [])
      Digest::MD5.hexdigest params.join('|')
    end
  
  end
end