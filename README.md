# Przelewy24 for rails4

This gem provide basic communication wrapper with przelewy24 payment API v.3.2

## Installation

Add this line to your application's Gemfile:

    gem 'rails4-przelewy24'

And then execute:

    $ bundle

## Configuration 

Required in Your config file:
    
    Przelewy24.configure do |config|
      config.merchant_id = <Integer:your_merchant_id>
      config.crc = <String:your_crc_from_przelewy24_profile>
      config.return_url = <String:url_to_return_from_payment_page>
    end

You can add separate configuration for your sandbox in development and test environments.

## Testing and Developing

In environments other than production, this module communicate with przelewy24 sandbox. This prevents requirement to make real money transfer when testing.

## Usage

Since this gem is only a function wrapper, You have to create Your own model for payments and transaction flow controller 
according to przelewy24 specification: https://www.przelewy24.pl/files/cms/13/przelewy24_specification.pdf.

### Initializing
Dont place p24_ prefix for options. Dont format Your amount to CURRENCY/100 type. This gem will do it for You.

    example_options = {session_id: 123, amount: 1.23, currency:'PLN', description:'desc', email:'mariusz.henn@gmail.com', country:'pl', url_status: 'http://example.com/status', url_return: 'http://example.com/success_transaction'}
    transaction = Przelewy24::Transaction.new example_options
 
### Registering transaction
 
    transaction.register_transaction

This function will provide transaction.token and transaction.transaction_url so You can redirect user to payment site.

### Verifying transaction status
Przelewy24 will send You transaction status to url_status. To verify validity of received params You can do:
 
    transaction.verify_transaction_status received_params

### Confirming transaction
To confirm transaction (it is required to process money transfer from customer to You in przelewy24 system)

    transaction.confirm_transaction
   
## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails4-przelewy24/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
