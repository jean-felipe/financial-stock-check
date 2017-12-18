require 'rails_helper'

RSpec.describe ListStockSymbol do
  subject do
    described_class.new(start_date: start_date, stock_symbol: stock_symbol)
  end

  describe '#process' do
    let(:start_date) { Date.today - 3.month }
    let(:stock_symbol) { 'AAL' }

    let(:response) { subject.call }

    it 'returns all the stock prices' do
      expect(response).to be_an_instance_of(Array)
    end

    context 'values in reponse array' do
      let(:response_array) { response.first }

      it 'return an array with code, price and date' do
        expect(response_array[0]).to eq('AAL')
        expect(response_array[1].to_date).to be_an_instance_of(Date)
        expect(response_array[2]).to be_kind_of(Float)
      end
    end
  end
end