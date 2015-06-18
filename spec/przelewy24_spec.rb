require 'spec_helper'

describe Przelewy24 do

  describe '#process' do

    before(:each) do
      # configure Przelewy24 to connect with sandbox user for tests
      Przelewy24.configure do |config|
        config.merchant_id = 37154
        config.crc = 'a65ac19629e9c9fa'
      end
      @payment = Przelewy24::Transaction.new
    end

    it 'tests connection' do
      expect(@payment.test_connection)
      .to equal true
    end

  end

  describe '#configure' do
    before do
      Przelewy24.configure do |config|
        config.merchant_id = 12345678
      end
    end

    it 'is configurable' do
      expect(Przelewy24.config.merchant_id)
      .to eq 12345678
    end
  end
end