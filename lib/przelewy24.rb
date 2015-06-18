require 'przelewy24/version'
require 'przelewy24/configuration'
require 'przelewy24/transaction'

module Przelewy24
  attr_writer :config

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield(config) if block_given?
  end

end
