class User < ActiveRecord::Base
  # Include default devise:database_authenticatable, modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs, through: :jobassignments
  has_many :jobassignments

  has_attached_file :avatar, :default_url => "/assets/missing.png"

  # Setup accessible (or protected) attributes for your model

  def full_name
  	"#{self.first_name} #{self.last_name}"
  end
end
