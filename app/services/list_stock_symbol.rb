class ListStockSymbol < BaseService

	def initialize(start_date:, stock_symbol:)
		@start_date   = start_date
		@stock_symbol = stock_symbol
	end

	def process!
		build_data
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
		@symbols = {}
		@prices.dig('datatable', 'data').map do |code, date, price|
			next unless code == @stock_symbol && date < @start_date.strftime
				@symbols.merge(symbol: code, date: date, price: price)
			end
			@symbols
		end
	end
end