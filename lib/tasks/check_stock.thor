class CheckStock < Thor
  STOCK_NAMES = %w(A AA AAL AAN AAMC).freeze

	desc "calculate the return the stock, you should inform an start date and the stock symbol.",
	 "return a list of stocks symbols"
	def check
		puts "Hello dude"
	end

	desc "list_symbols", "list the stock symbols"
	def list_symbols
		get_name
    validate_name(@name) ? get_date : show_examples
	end

  def get_year
    puts "please inform the year, it should be yyyy (4 digits)"
    @year = STDIN.gets.chomp
    return_error("year") unless @year.length == 4 && @year >= "1988" && @year <= "1999"
  end

  def get_month
    puts "please inform the month, it should be mm (2 digits)"
    @month = STDIN.gets.chomp
    return_error("month") unless @month.length == 2 && @month > "0" && @month <= "12"
  end

  def get_day
    puts "please inform the day, it should be dd (2 digits)"
    @day = STDIN.gets.chomp
    return_error("day") unless @day.length == 2 && @day > "0" && @day <= "30"
  end

  private

  def get_date
    puts "inform a date that we will get the values since this date, it should be yyyy-mm-dd"
    get_year
    get_month
    get_day
  end

  def get_name
    puts "please, selec the stock name:\n (1) - A\n (2) - AA\n (3) - AAL\n (4) - AAN\n (5) - AAMC"
    input = STDIN.gets.chomp
    set_name(input.to_i)
  end

  def return_error(type)
    generic_date_error_message(type)
    public_send("get_#{type}")
  end

  def generic_date_error_message(label)
    puts "you should insert a valid #{label}"
  end

  def show_examples
    puts "The valid names is A, AA, AAL, AAN, AAMC, please choose one."
    get_name
  end

  def set_name(input)
    @name ||=
    case input
      when 1 then "A"
      when 2 then "AA"
      when 3 then "AAL"
      when 4 then "AAN"
      when 5 then "AAMC"
    end
  end

  def validate_name(name)
    STOCK_NAMES.include?(name)
  end
end