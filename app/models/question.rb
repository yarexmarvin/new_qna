class Question < ApplicationRecord
  include Votable

  belongs_to :user

  has_one :award, dependent: :destroy

  has_many_attached :files

  has_many :links, dependent: :destroy, as: :linkable
  
  has_many :answers, -> { order(best: :desc) }, dependent: :destroy

  has_many :comments, dependent: :destroy
  
  accepts_nested_attributes_for :links, :award, reject_if: :all_blank, allow_destroy: true
  
  validates :title, :body, presence: true
end
