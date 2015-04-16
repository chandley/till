require 'receipt'

describe Receipt do
  let(:tea) { double :item, name: 'tea', price: 1 }
  let(:cake) { double :item, name: 'cake', price: 2 }

  context 'header' do
    it 'shows shop name' do
      till = double :till
      receipt = Receipt.new(till)
      expect(receipt.header[:shopName]).to eq('Todd pies')
    end
  end

  context 'line items' do
    it 'has name, quantity and unit price' do
      till = double :till, items: [tea]
      receipt = Receipt.new(till)
      expect(receipt.line_items).to include(name: 'tea', quantity: 1, price: 1)
    end
    it 'shows quantity for multiples of same item' do
      till_multiple_items = double :till, items: [tea, tea]
      receipt = Receipt.new(till_multiple_items)
      expect(receipt.line_items).to include(name: 'tea', quantity: 2, price: 1)
    end
    it 'shows two different items' do
      till_different_items = double :till, items: [tea, cake]
      receipt = Receipt.new(till_different_items)
      expect(receipt.line_items).to include(name: 'tea', quantity: 1, price: 1)
      expect(receipt.line_items).to include(name: 'cake', quantity: 1, price: 2)
    end
  end

  context 'totals' do
    let(:till) { double :till, tax: 0.15, discount_description: 'description' }
    let(:receipt) { Receipt.new(till) }

    it 'shows tax' do
      expect(receipt.totals).to include(tax: 0.15)
    end
    it 'shows one discount calculation' do
      expect(receipt.totals).to include(discount: 'description')
    end
  end
end
