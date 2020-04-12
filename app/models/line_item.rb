class LineItem < ApplicationRecord
  belongs_to :instrument
  belongs_to :cart

  def total_price
    instrument.price.to_i * quantity
  end
end
