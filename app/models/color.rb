class Color < ApplicationRecord
  REGULAR_FOR_COLOR = /\A#(?:[0-9a-fA-F]{3}){1,2}\z/

  validates :name, :hex, presence: true, uniqueness: true
  validates :hex, format: { with: REGULAR_FOR_COLOR }

  before_validation :to_lower_case

  private

  def to_lower_case
    name&.downcase!
  end
end
