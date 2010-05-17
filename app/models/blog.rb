class Blog < ActiveRecord::Base
  has_many :bloggings
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  has_site if respond_to? :has_site

  validates_presence_of :title
  validates_format_of :slug, :with => %r{^([-_.A-Za-z0-9]*|/)$}, :allow_nil => true
  validates_uniqueness_of :slug, :allow_nil => true
end