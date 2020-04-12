class Instrument < ApplicationRecord
  mount_uploader :image, ImageUploader
  serialize :image, JSON # si se utiliza SQLite

  belongs_to :user, optional: true
  has_many :line_items

  BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS Ibanez Charvel Washburn }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed." }
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed." }
  validates :price, numericality: { only_integer: true }, length: { maximum: 7 }
  validates :brand, inclusion: { in: BRAND }
  validates :finish, inclusion: { in: FINISH }
  validates :condition, inclusion: { in: CONDITION }

  before_destroy :not_referenced_by_any_line_item

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end
end
