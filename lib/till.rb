class Till
  require 'json'
  attr_reader :items
  attr_reader :list
  attr_writer :tax_rate
  def initialize
    @items = []
    @tax_rate = 0
  end

  def total
    @items.reduce(0){ |sum, item| sum + item.price }
  end

  def tax
    total*@tax_rate
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
