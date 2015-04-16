class Receipt
  def initialize till
    @till = till
  end
  def line_items
    @till.items.uniq.map {|item| line_item(item)}
  end
  def line_item(item)
    {name: 'tea', quantity: @till.items.count(item), price: 1}
  end
  def quantities
    @till.items.each_with_object(Hash.new(0)){|item, counts| counts[item] += 1}
  end
end
