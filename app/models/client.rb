class Client < ActiveRecord::Base
  has_attached_file :logo, :default_url => "assets/missing-5af4bdd80ad9ae0116dee1291f7ad902.png"
  has_many :jobs
end
