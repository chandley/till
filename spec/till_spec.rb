require 'till'

describe Till do
  context 'items in order' do
    it "starts off with none" do
      expect(subject.items).to eq([])
    end
    it "can add: one" do
      subject.add(:item)
      expect(subject.items).to include(:item)
    end
  end
  context 'total' do
    let(:till){ Till.new }
    let(:tea){double :item, price: 1}
    let(:cake){double :item, price: 2}
    it 'calculates with one item' do
      till.add(tea)
      expect(till.total).to eq(1)
    end
    it 'calculates with two items' do
      till.add(tea)
      till.add(cake)
      expect(till.total).to eq(3)
    end
  end
  context 'till header' do
    it 'reads shop name from json file' do
      subject.read('./hipstercoffee.json')
      expect(subject.list["shopName"]).to eq 'The Coffee Connection'
    end
  end

end
