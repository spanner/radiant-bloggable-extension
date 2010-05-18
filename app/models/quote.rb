class Quote < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  
  is_bloggable
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  has_site if respond_to? :has_site

  validates_presence_of :body, :speaker
  
  def title
    truncate(body, :length => 123, :omission =>"&hellip;")
  end
  
end
