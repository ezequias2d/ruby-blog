class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :text, presence: true, length: { minimum: 10, maximum: 600 }
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
end
