# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  email            :string(255)
#  password_digest  :string(255)
#  name             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  last_login       :datetime
#  notify_new_posts :boolean         default(TRUE)
#
require 'digest/md5'

class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation, :name, :notify_new_posts
    has_secure_password

    validates_uniqueness_of :email
    validates_presence_of :password, :on => :create
    validates_format_of :email, :with => /\A(\w+)\.(\w+)@uni-rostock\.de\Z/i

    before_save :extract_name_from_email

    has_many :comments
    has_many :visits
    has_many :events

    include Gravtastic
    gravtastic :filetype => :png, :size => 80

    # Public: generates a unique token that is used for remote authentication
    #
    # Returns the MD5 crypted data as a hash
    def remote_auth_token
      pattern = "#{self.email}_#{self.name}_#{self.created_at}"
      return Digest::MD5.hexdigest pattern
    end

    # Public: Return the last time the page is viewed by the user
    #
    # Returns a datetime
    def last_page_visit
      last_visit = Visit.find_by_user_id(self)
      if last_visit && last_visit.updated_at > self.last_login
        return last_visit.updated_at
      end

      return self.last_login
    end

    def extract_name_from_email

      unless attribute_present?(:name)
        if ( match =  self.email.match(/^(\w+)\.(\w+)@(.*)\.(.+)$/))
          self.name = "#{match[1].capitalize} #{match[2].capitalize}"
        end
      end
    end

    def self.normalize_email(email)
      unless email.match(/@\S+\./)
        email = "#{email}@uni-rostock.de"
      end
      email
    end
end
