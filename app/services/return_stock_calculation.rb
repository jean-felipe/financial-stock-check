class ReturnStockCalculation < BaseService

  attr_reader :drawdown, :response

  # To initialize this service
  # { values } should be an array with values to be calculated
  #
  # This array should contain the stock values from prices.json file
  # and should contain the follow required data:
  #  [code, date, open, high, low, close]
  #
  # 1 - code = it is the stock code
  # 2 - date = is the date related with tha stock and the other proce values
  # 3 - open = price when the stock was open in that date
  # 4 - high = the high price which that stock got on that date
  # 5 - low = is the lowest price that the stock got on that date
  # 6 - close = the price that stock got when the day was closed
  #

  def initialize(values)
    @values = values
  end

  def process!
    build_data
    @response = { drawdown: @drawdown, stock_return: @stock_return }
  end

  private

  def build_data
    build_drawdown_data
    build_stock_return_data
  end

  # Method to build and calculate the stock prices
  def build_stock_return_data
    open_values = []
    close_values  = []

    @values.dig(:values).map do |_codes, _date, open, _high, _low, close|
      open_values.push [open]
      close_values.push [close]
    end

    @open  = calculate_average(open_values)
    @close = calculate_average(close_values)
    @stock_return = stock_return_formula
  end

  # Method to calculate the drawdown prices
  def build_drawdown_data
    high_values = []
    low_values  = []

    @values.dig(:values).map do |_codes, _date, _open, high, low, _close|
      high_values.push [high]
      low_values.push [low]
    end

    @high = calculate_average(high_values)
    @low  = calculate_average(low_values)
    @drawdown = max_drawdown_formula
  end

  def max_drawdown_formula
   result = (@low - @high).fdiv(@high)
    ("%.2f" % result).to_f
  end

  def stock_return_formula
    result = (@close - @open).fdiv(@open)
    ("%.3f" % result).to_f
  end

  # Shared method to calculate the average
  def calculate_average(values)
    count = values.count
    total = values.map(&:first).inject(:+)
    average = (total).fdiv(count)
    ("%.3f" % average).to_f
  end
end
