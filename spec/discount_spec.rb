require 'discount'

describe Discount do 
  it 'has zero value with no items in till' do
    discount = Discount.new
    till = double :till, total: 0, items: []
    expect(discount.value(till)).to eq(0)
  end

  it 'can apply a 10% discount' do
    discount = Discount.new { |till| till.total*0.1}
    till = double :till, total:50
    expect(discount.value(till)).to eq(5)
  end
  it 'can apply a 20% discount' do
    discount = Discount.new { |till| till.total*0.2}
    till = double :till, total:50
    expect(discount.value(till)).to eq(10)
  end

  it 'has zero value below threshold' do
    discount = Discount.new { |till| till.total <= 60 ? 0 : till.total*0.1 }
    till = double :till, total:50
    expect(discount.value(till)).to eq(0)
  end
  it 'has normal value above threshold' do
    discount = Discount.new { |till| till.total <= 60 ? 0 : till.total*0.1 }
    till = double :till, total:70
    expect(discount.value(till)).to eq(7)
  end

  
end
