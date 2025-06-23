require 'logger'
require 'minitest/autorun'
require 'mocha/minitest'
require 'httparty'
require 'pry'
require_relative '../app/currency_converter'

describe CurrencyConverter do
  before do
    @converter = CurrencyConverter.new
  end

  describe '#convert' do
    it 'Correctly calculate the total amount in fiat with real application format' do
      data = {
        'portfolio' => {
          'BTC' => 0.5,
          'ETH' => 2.0,
          'USDT' => 1000
        },
        'fiat_currency' => 'CLP'
      }

      prices = {
        'BTC' => '100000.0',
        'ETH' => '5000.0',
        'USDT' => '1000.0'
      }

      prices.each do |crypto, price|
        response = mock
        response.expects(:success?).returns(true)
        response.expects(:parsed_response).returns({'ticker' => {'last_price' => [price]}})
        
        HTTParty.expects(:get)
          .with("https://www.buda.com/api/v2/markets/#{crypto}-CLP/ticker")
          .returns(response)
      end

      result = @converter.convert(data)
      assert_equal(result, {amount: '$1060000.0 CLP'})
    end

    it 'Raises an error if HTTP call fails with all three cryptocurrencies' do
      data = {
        'portfolio' => {
          'BTC' => 0.5,
          'ETH' => 2.0,
          'USDT' => 1000
        },
        'fiat_currency' => 'CLP'
      }

      failed_response = mock
      failed_response.expects(:success?).returns(false)
      failed_response.expects(:code).returns(500)
      HTTParty.expects(:get).with('https://www.buda.com/api/v2/markets/BTC-CLP/ticker').returns(failed_response)

      assert_raises(RuntimeError) do
        @converter.convert(data)
      end
    end
  end
end