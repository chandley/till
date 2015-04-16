class Discount
  def value till
    calculation = Proc.new { |till| till.total*0.1}
    calculation.call till
  end
end
