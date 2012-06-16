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
