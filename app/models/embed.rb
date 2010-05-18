class Embed < ActiveRecord::Base
  is_bloggable
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  has_site if respond_to? :has_site

  validates_presence_of :body
end
