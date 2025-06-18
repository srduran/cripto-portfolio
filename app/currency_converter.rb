class CurrencyConverter
  def convert(data)
    portfolio = data['portfolio']
    fiat_currency = data['fiat_currency']
    amount = portfolio.map { |crypto, amount| get_rates(crypto, fiat_currency) * amount }.sum
    {
      amount: "$#{amount} #{fiat_currency}"
    }
  end

  private
  def get_rates(crypto_currency, fiat_currency)
    url = "https://www.buda.com/api/v2/markets/#{crypto_currency}-#{fiat_currency}/ticker"
    response = HTTParty.get(url)
    if response.success?
      response.parsed_response['ticker']['last_price'].first.to_f
    else
      raise "Failed to get rates, error: #{response.code}"
    end
  end
end