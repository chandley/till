class Receipt
  def initialize till
    @till = till
  end
  def line_items
    @till.items.uniq.map {|item| line_item(item)}
  end
  def header
    { shopName: 'Todd pies' }
  end
  def totals
   { tax: 0.15, discount: 'description'}
  end

  private
  def line_item(item)
    {name: item.name, quantity: @till.items.count(item), price: item.price}
  end
end
