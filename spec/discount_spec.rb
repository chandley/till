require 'discount'

describe Discount do
  let(:till) { double :till, total: 50 }
  context 'no items' do
    it 'has zero value' do
      discount = Discount.new
      no_order_till = double :till, total: 0, items: []
      expect(discount.value(no_order_till)).to eq(0)
    end
  end

  context 'fixed discount' do
    it 'can apply 10%' do
      discount = Discount.new { |till| till.total * 0.1 }
      expect(discount.value(till)).to eq(5)
    end
    it 'can apply 20%' do
      discount = Discount.new { |till| till.total * 0.2 }
      expect(discount.value(till)).to eq(10)
    end
    it 'has a description when 10%' do
      discount = Discount.new { |till| till.total * 0.1 }
      expect(discount.description(till)).to eq('10% from $50.00')
    end
    it 'has a description when 20%' do
      discount = Discount.new { |till| till.total * 0.2 }
      expect(discount.description(till)).to eq('20% from $50.00')
    end
  end

  context 'discount with limit' do
    it 'has zero value below limit' do
      discount = Discount.new { |till| till.total <= 60 ? 0 : till.total * 0.1 }
      expect(discount.value(till)).to eq(0)
    end
    it 'has normal value above limit' do
      discount = Discount.new { |till| till.total <= 60 ? 0 : till.total * 0.1 }
      big_till = double :till, total: 70
      expect(discount.value(big_till)).to eq(7)
    end
  end

  context 'muffin discount' do
    muffin_calc = proc do |till|
      discount = 0.1
      muffins = till.items.select { |item| item.name == 'muffin' }
      values = muffins.map &:price
      values.reduce(0, :+) * discount
    end

    let(:tea) { double :item, name: 'tea' }
    let(:muffin) { double :item, name: 'muffin', price: 10 }
    let(:discount) { Discount.new &muffin_calc }

    it 'does not apply generally' do
      till = double :till, items: [tea]
      expect(discount.value(till)).to eq(0)
    end
    it 'applies to a muffin' do
      till = double :till, items: [muffin]
      expect(discount.value(till)).to eq(1)
    end
    it 'applies seletively to multiple mixed items' do
      till = double :till, items: [muffin, muffin, tea, tea, muffin]
      expect(discount.value(till)).to eq(3)
    end
  end
end
