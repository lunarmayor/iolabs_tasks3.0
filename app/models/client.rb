class Client < ActiveRecord::Base
  has_attached_file :logo, :default_url => "missing.png"
  has_many :jobs
end
