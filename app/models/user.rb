class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one :profile, dependent: :destroy

  if Rails.env.development?
		has_attached_file :avatar, styles: { medium: "200x200", thumb: "100x100>" }, default_url: "defaultImage.png"
		validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png)
	else
		has_attached_file :avatar, styles: { medium: "200x200", thumb: "100x100>" }, default_url: "defaultImage.png",:storage => :dropbox,
    	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    	:path => ":style/:id_:filename"
		validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png)
	end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :nickname, presence: true

  has_many :posts, dependent: :destroy
end
