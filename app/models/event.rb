# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  time        :datetime
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#  place       :string(255)
#

class Event < ActiveRecord::Base
  attr_accessible :time, :description, :place

  validates_presence_of :time, :description, :user_id
  validates_length_of :description, :within => 5..500

  belongs_to :user

  default_scope :order => "time"

  scope :in_future,  lambda{ where("time > ?", Time.now) }
  scope :limit, lambda { |num| { :limit => num } }
end
