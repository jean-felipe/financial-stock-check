class ReturnStockCalculation < BaseService

  def initialize(values:)
    @values = values
  end

  def process!
    build_data
  end

  private

  def build_data
    build_drawdown_data
  end

  def build_stock_return_data
    open_values = []
    close_values  = []

    @values.map do |_codes, _date, open, _high, _low, close|
      open_values.push [open]
      close_values.push [close]
    end

    @open = calculate_average(open_values)
    @close = calculate_average(close_values)
    @stock_return = stock_return_formula
  end

  def build_drawdown_data
    high_values = []
    low_values  = []

    @values.map do |_codes, _date, _open, high, low, _close|
      high_values.push [high]
      low_values.push [low]
    end

    @high = calculate_average(high_values)
    @low  = calculate_average(low_values)
    @drawdown = max_drawdown_formula
  end

  def max_drawdown_formula
    (@high - @low).div(@high)
  end

  def stock_return_formula
    (@open - @close).div(@open)
  end

  def calculate_average(values)
    count = values.count
    total = values.map(&:first).inject(:+)
    media = (total).div(count)
  end
end