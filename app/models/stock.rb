class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

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
