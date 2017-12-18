require 'rails_helper'

RSpec.describe ReturnStockCalculation do
  subject do
    described_class.new(values: values)
  end

  let(:response) { subject.call }

  describe '#process!' do
    let(:values) do
      [
        ["AA", "1999-11-18", 45.5, 50.0,  30.0, 44.0],
        ["AA", "1999-11-18", 55.5, 100.0, 20.0, 150.0],
        ["AA", "1999-11-18", 65.5, 250.0, 20.0, 65.0],
        ["AA", "1999-11-18", 75.5, 40.0,  10.0, 200.0]
      ]
    end

    it 'return the drawdown and stock return values' do
      expect(response).to be_an_instance_of(Hash)
      expect(response[:drawdown]).to eq(-0.82)
      expect(response[:stock_return]).to eq(0.897)
    end
  end
end