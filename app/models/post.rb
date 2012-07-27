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
  attr_accessible :message, :user

  validates_presence_of :message, :user_id
  validates_length_of :message, :within => 15..10000

  belongs_to :user
  has_many :visits
  has_many :comments

  default_scope :order => "updated_at DESC"

  auto_html_for :message do
    html_escape
    link :target => "_blank", :rel => "nofollow"
    image
    gist
    redcarpet
    google_map(:width => 400, :height => 250)
    youtube(:width => 400, :height => 250)
    simple_format
  end

  # Public: the last modification time (post of comment if there are any)
  #
  # Returns the specific datetime
  def last_activity
    if self.comments.size > 0
      self.comments.last.updated_at
    else
      self.updated_at
    end
  end

  # Public: find the user that acts last on this post
  #
  # Returns the specific datetime
  def last_active_user
    if self.comments.size > 0
      self.comments.last.user
    else
      self.user
    end
  end

  # public: is post newer than the supplied datetime
  #
  # datetime - compared time
  #
  # Returns true if the post is newer, false otherwise
  def is_newer_than?(datetime)
    return false unless datetime

    self.updated_at > datetime
  end

  # Public: get comments that are newer than time
  #
  # datetime - compared time
  #
  # Returns an array with new comments, empty array otherwise
  def comments_newer_than(datetime)
    return [] unless datetime

    self.comments.select { |c| c.created_at > datetime }
  end
end
