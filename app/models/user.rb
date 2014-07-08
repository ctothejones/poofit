class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  belongs_to :league
  belongs_to :team
  has_many :authentications

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :url  => "/assets/users/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/


  def name
    "#{first_name} #{last_name}"
  end
end
