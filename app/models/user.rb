class User < ApplicationRecord
  before_save { self.username = username.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

         has_many :videos, dependent: :destroy
         
         validates :username, presence: true, uniqueness: { case_sensitive: false }
         validate :validate_username
         validate :validate_phone
        
        ##...Avatar Attachment...##
        has_one_attached :avatar
        validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
                  file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

         attr_writer :login

         def login
          @login || self.username || self.email || self.phone_number
         end

        def self.find_for_database_authentication(warden_conditions)
          conditions = warden_conditions.dup
          if (login = conditions.delete(:login))
            where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(phone_number) = :value", { :value => login.downcase }]).first
          elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:phone_number)
            where(conditions.to_h).first
          end
        end

        def validate_username
          if User.where(email: username).exists?
            errors.add(:username, :invalid)
          end
        end

        def validate_phone
          if User.where(email: phone_number).exists?
            errors.add(:phone_number, :invalid)
          end
        end
end
