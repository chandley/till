require 'till'

describe Till do
  it "starts off empty" do
    expect(subject.items).to eq([])
  end
end
