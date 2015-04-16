class Discount

  def initialize (&calculation)
    @calculation = calculation
  end
  def value till
    return 0 if @calculation.nil?
    @calculation.call till
  end
  def description till
    '10% from $50.00'
    percentage = value(till)/till.total*100
    "#{'%.0f' % percentage}% from $#{'%.2f' % till.total}"
  end
end
