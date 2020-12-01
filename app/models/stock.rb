class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_client[:api_tokens])
    stock = StockQuote::Stock.quote(ticker_symbol)
    stock.latest_price
  end
end
