require 'spec_helper'
require 'action_controller'
describe Przelewy24 do

  before do
    Przelewy24.configure do |config|
      config.merchant_id = 37154
      config.crc = 'a65ac19629e9c9fa'
      config.url_return = 'http://example.com/success_transaction'
    end
  end

  context 'is configurable' do
    let(:merchant_id) { Przelewy24.config.merchant_id }
    it { expect(merchant_id).to equal 37154 }
  end

  describe Przelewy24::Transaction do
    let(:options) {{order_id:18506028, session_id: 1, amount: 1.23, currency:'PLN', description:'desc', email:'mariusz.henn@gmail.com', country:'pl', url_status: 'example.com/status', url_return: 'http://example.com/success_transaction'}}
    subject (:transaction){ Przelewy24::Transaction.new options }

    context '#transaction' do
      xit 'register transaction' do
        transaction.register_transaction
        puts transaction.token
        expect(transaction.token).to be_a_kind_of String
      end

      it 'verifying received transaction status' do
        params =ActionController::Parameters.new({'p24_merchant_id' => 37154,
                       'p24_pos_id' => 37154,
                       'p24_session_id' => 1,
                       'p24_amount'=> 123,
                       'p24_currency' => 'PLN',
                       'p24_order_id'=> 18506028,
                       'p24_method'=> 16,
                       'p24_statement'=> 'payment for invoice',
                       'p24_sign'=> '8d2137c81c95c449c7dea25354c34dc4'})
       expect(transaction.verify_transaction_status(params)).to equal true
      end

      it {expect(transaction.confirm_transaction).to equal true}
    end

    context '#test_connection' do
      it { expect(transaction.test_connection).to equal true }
    end

  end
end