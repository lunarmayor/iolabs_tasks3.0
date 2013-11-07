class Job < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :jobassignments
  has_many :jobassignments
  belongs_to :client
  has_many :notes

  def compact_date(attribute)
  	date_array = self.send(attribute).split('/')
  	result_array = Array.new
  	[2,0,1].each do |n|
  		result_array << date_array[n]
    end
    result_string = result_array.join()
    return result_string
  end

  def self.compact_date(attribute)
    date_array = attribute.split('/')
    result_array = Array.new
    [2,0,1].each do |n|
      result_array << date_array[n]
    end
    result_string = result_array.join()
    return result_string
  end

  def self.uncompact_date(attribute)
    result_array = Array.new
    result_array << attribute[6..7]
    result_array << attribute[4..5]
    result_array << attribute[0..3]
    result_array.join('/')
  end
end
