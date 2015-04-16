class Till
  require 'json'
  attr_reader :items, :discounts
  attr_reader :list
  attr_writer :tax_rate
  def initialize
    @items = []
    @discounts = []
    @tax_rate = 0
  end

  def total
    @items.reduce(0){ |sum, item| sum + item.price }
  end

  def final_total
    total - discounts_value - tax
  end

  def tax
    total*@tax_rate
  end

  def discounts_value
    @discounts.map{|discount| discount.value}.first
  end

  def add item
    @items << item
  end
  
  def add_discount discount
    @discounts << discount
  end
  def read(path)
    file = File.read(path)
    data_hash = JSON.parse(file)
    @list = data_hash.first
  end
end
