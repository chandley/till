require 'receipt'

describe Receipt do
  let(:tea) {double :item, name: 'tea', price: 1}
  let(:till) {double :till, items: [:tea]}
  let(:receipt) {Receipt.new(till)}
  context 'line items' do
    it 'has name, quantity and unit price' do
      expect(receipt.line_items).to eq([{name: 'tea', quantity: 1, price: 1}])
    end
    it 'shows quantity for multiples of same item' do
      till_multiple_items = double :till, items: [:tea, :tea]
      receipt = Receipt.new(till_multiple_items)
      expect(receipt.line_items).to eq([{name: 'tea', quantity: 2, price: 1}])
    end
  end
end
