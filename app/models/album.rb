class Album < ApplicationRecord
    has_one_attached :cover_image
    has_many_attached :images
    belongs_to :user
    has_many :taggings
    has_many :tags, through: :taggings
end

