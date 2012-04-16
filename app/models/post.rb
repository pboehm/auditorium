# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  message    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

class Post < ActiveRecord::Base
  validates_presence_of :message, :user_id
  validates_length_of :message, :within => 15..600

  has_many :comments
  belongs_to :user

  default_scope :order => "updated_at DESC"

  auto_html_for :message do
    html_escape
    image
    gist
    redcarpet
    google_map(:width => 400, :height => 250)
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
