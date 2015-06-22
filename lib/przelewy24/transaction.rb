require 'httparty'
require 'json'

module Przelewy24
  class Transaction
    attr_accessor :options
    attr_reader :token

    def initialize(options = {})
      @conf = Przelewy24.config
      @options = @conf.default_transaction_options.merge p24_options options
    end

    def test_connection
      params = create_params @conf.test_connection_params
      sign params, %w(p24_pos_id)
      verify_params params
      response = query_p24 @conf.test_url, params
      response['error'] == '0'
    end

    def register_transaction
      return if @options[:p24_order_id].present?
      params = create_params @conf.register_transaction_params
      sign params, %w(p24_session_id p24_merchant_id p24_amount p24_currency)
      verify_params params
      response = query_p24 @conf.register_url, params
      @token = response['token']
      params.merge({:p24_token => @token})
      params[:transaction_url] = @conf.request_url + @token
    end

    def verify_transaction_status(params)
      p24_sign = params['p24_sign']
      sign params, %w(p24_session_id p24_order_id p24_amount p24_currency)
      p24_sign == params['p24_sign']

    end

    def confirm_transaction
      params = create_params @conf.confirm_transaction_params
      sign params, %w(p24_session_id p24_order_id p24_amount p24_currency)
      verify_params params
      response = query_p24 @conf.confirm_transaction_url, params
      response['error'] == '0'
    end

    private

    attr_writer :conf

    def p24_options(options)
      out = {}
      options.each do |k, v|
        out[('p24_'+k.to_s).to_sym] = v
      end
      out[:p24_amount] = (out[:p24_amount]*100).to_int
      out
    end

    def query_p24(url, params)
      response = HTTParty.post url, body: params
      response = Rack::Utils.parse_nested_query response.parsed_response
      raise response['error']+': '+response['errorMessage'] unless response['error'] == '0'
      response
    end

    def verify_params(params)
      params.each do |p, v|
        raise "#{p} cannot be nil" unless v.present?
      end
    end

    def create_params(source_params = {})
      params = {}
      source_params.each do |k, v|
        params[k] = @options[k]
      end
      params
    end

    def sign(params, with_params = {})
      p = []
      with_params.each do |k|
        p << @options[k.to_sym]
      end
      p << @conf.crc
      s = Digest::MD5.hexdigest p.join('|')
      params[:p24_sign] = s
    end
  
  end
end
