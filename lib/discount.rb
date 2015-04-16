class Discount

  def initialize (&calculation)
    @calculation = calculation
  end
  def value till
    return 0 if @calculation.nil?
    @calculation.call till
  end
end
