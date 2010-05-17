class Embed < ActiveRecord::Base
  is_bloggable
  belongs_to :embed_type
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  has_site if respond_to? :has_site
  
  def friendly_title
    "Embedded html"
  end
  
  def render
    
  end
end
