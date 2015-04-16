class Till
  attr_reader :items

  def initialize
    @items = []
  end

  def add item
    @items.push item
  end
end
