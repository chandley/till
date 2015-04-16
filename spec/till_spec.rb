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
    it 'calculates with one item' do
      till.add(tea)
      expect(till.total).to eq(1)
    end
  end
end
