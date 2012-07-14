# == Schema Information
#
# Table name: visits
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Visit < ActiveRecord::Base
  attr_accessible :updated_at, :user, :post

  belongs_to :user
  belongs_to :post

  validates_presence_of :user
  validates_presence_of :post

  validates_uniqueness_of :user_id, :scope => :post_id

  default_scope :order => 'updated_at DESC'
end
