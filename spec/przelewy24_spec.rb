require 'spec_helper'

describe Przelewy24 do

  before do
    Przelewy24.configure do |config|
      config.merchant_id = 37154
      config.crc = 'a65ac19629e9c9fa'
    end
  end

  subject {Przelewy24::Transaction.new}

  context '#process' do
    it { expect(subject.test_connection).to equal true }

  end

  context '#configure' do
    it 'is configurable' do
      expect(Przelewy24.config.merchant_id).to equal 37154
    end
  end
end