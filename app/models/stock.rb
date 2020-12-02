class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    StockQuote::Stock.new(api_key: Rails.application.credentials.iex_client[:api_tokens])
    begin
      stock = StockQuote::Stock.quote(ticker_symbol)
      new(ticker: ticker_symbol, name: stock.company_name, last_price: stock.latest_price)
    rescue => exception
      return nil
    end
  end
end
