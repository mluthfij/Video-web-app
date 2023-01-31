class Video < ApplicationRecord
    belongs_to :user
    has_many_attached :files
    # has_many_attached :images
end
