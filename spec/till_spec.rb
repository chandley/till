require 'till'

describe Till do
  let(:till){ Till.new }
  let(:tea){double :item, price: 1}
  let(:cake){double :item, price: 2}
  let(:discount) {double :discount, value: 0}

  context 'items in order' do
    it "starts off with none" do
      expect(subject.items).to eq([])
    end
    it "adds one" do
      subject.add(:item)
      expect(subject.items).to include(:item)
    end
  end
  context 'total' do
     it 'calculates with one item' do
      till.add(tea)
      expect(till.total).to eq(1)
    end
    it 'calculates with two items' do
      till.add(tea)
      till.add(cake)
      expect(till.total).to eq(3)
    end
    it 'calculates tax' do
      till.add(tea)
      till.tax_rate = 0.15
      expect(till.tax).to eq(0.15)
    end
    it 'calculates discounts for final total' do
      till.add(tea)
      till.add_discount(discount)
      expect(discount).to receive(:value)
      till.final_total
    end
  end
  context 'discount' do
    let(:discount){double :discount}
    it 'starts off with none' do
      expect(till.discounts).to eq([])
    end
    it 'adds one' do
      till.add_discount(discount)
      expect(till.discounts).to include(discount)
    end
    it 'calculates discounts' do
      till.add(tea)
      till.add_discount(discount)
      expect(discount).to receive(:value)
      till.discounts_value
    end
  end
  context 'till header' do
    it 'reads shop name from json file' do
      subject.read('./hipstercoffee.json')
      expect(subject.list["shopName"]).to eq 'The Coffee Connection'
    end
  end

end
