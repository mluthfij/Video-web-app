class Video < ApplicationRecord
    belongs_to :user
    has_one_attached :file
    validates :title, presence: true,
                length: { minimum: 5, maximum: 100 }
    validates :body, presence: true,
                length: { minimum: 5, maximum: 500 }
end
