class Tag < ApplicationRecord
  TAG_REGEX = /#[[:lower:]+_]+/

  has_many :tag_questions, dependent: :destroy
  has_many :questions, through: :tag_questions

  scope :with_questions, -> { joins(:questions).distinct }

  before_validation { name&.downcase! }
  validates :name, presence: true

  before_save :delete_hashtag

  private

  def delete_hashtag
    self.name.delete!("#")
  end
end