class Client < ActiveRecord::Base
  has_attached_file :logo, :default_url => ActionController::Base.helpers.asset_path("assets/missing.png")
  has_many :jobs
end
