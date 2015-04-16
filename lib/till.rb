class Till
  require 'json'
  attr_reader :items
  attr_reader :list
  def initialize
    @items = []
  end

  def total
    @items.reduce(0){ |sum, item| sum + item.price }
  end

  def add item
    @items.push item
  end

  def read(path)
    file = File.read(path)
    data_hash = JSON.parse(file)
    @list = data_hash.first
  end
end
