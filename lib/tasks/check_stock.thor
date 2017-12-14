class CheckStock < Thor
	desc "calculate the return the stock, you should inform an start date and the stock symbol.",
	 "return a list of stocks symbols"
	def check
		puts "Hello dude"
	end

	desc "list_symbols", "list the stock symbols"
	def list_symbols
		puts "dude"
	end
end