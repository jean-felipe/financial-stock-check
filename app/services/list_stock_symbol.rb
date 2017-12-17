class ListStockSymbol < BaseService
  attr_reader :stock_values

  # This service returns an Array with prices for a single stock
  # To initialize this you should inform:
  # 1 - An start date e.g 2017-10-02
  # 2 - The stock symbol e.g AAL
  #
  # => the response will be an array with prices separeted by date

	def initialize(start_date:, stock_symbol:)
		@start_date   = start_date.to_date
		@stock_symbol = stock_symbol
	end

	def process!
		build_data
    find_symbol_by_data_range
	end

	private

	def build_data
		load_prices
		find_symbol_by_data_range
	end

	def load_prices
		price_file = File.read('prices.json')
		@prices = JSON.parse(price_file)
	end

	def find_symbol_by_data_range
		@stock_values = []
		@prices.dig('datatable', 'data').map do |code, date, open, high, low, close|
			if code == @stock_symbol && date > @start_date.strftime
			  @stock_values.push [code, date, open, high, low, close]
      else
        next
      end
		end
      @stock_values
	end
end
