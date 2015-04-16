require 'till'

describe Till do
  context 'items' do
    it "starts off with none" do
      expect(subject.items).to eq([])
    end
    it "adds one" do
      subject.add(:item)
      expect(subject.items).to include(:item)
    end
  end
end
