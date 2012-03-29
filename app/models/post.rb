# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  message    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
  validates_presence_of :message
  validates_length_of :message, :within => 15..600

  has_many :comments
end
