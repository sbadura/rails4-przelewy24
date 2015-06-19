require 'spec_helper'

describe Przelewy24 do

  before do
    Przelewy24.configure do |config|
      config.merchant_id = 37154
      config.crc = 'a65ac19629e9c9fa'
      config.return_url = 'http://example.com/success_transaction'
    end
  end

  context 'is configurable' do
    let(:merchant_id) { Przelewy24.config.merchant_id }
    it { expect(merchant_id).to equal 37154 }
  end

  describe Przelewy24::Transaction do
    let(:options) {{session_id: 1, amount:123, currency:'PLN', description:'desc', email:'mariusz.henn@gmail.com', country:'pl', url_return: 'http://example.com/success_transaction'}}
    subject (:transaction){ Przelewy24::Transaction.new options }
    context '#transaction' do
      it 'register transaction' do
        transaction.register_transaction
        puts transaction.token
        expect(transaction.token).to be_a_kind_of String
      end

    end

    context '#test_connection' do
      it { expect(transaction.test_connection).to equal true }
    end
  end
end