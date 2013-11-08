class Client < ActiveRecord::Base
  has_attached_file :logo, :default_url => "images/missing.png"
  has_many :jobs
end
