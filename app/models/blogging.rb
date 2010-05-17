class Blogging < ActiveRecord::Base
  has_site if respond_to? :has_site
  belongs_to :blog
  belongs_to :subject, :polymorphic => true
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  accepts_nested_attributes_for :subject, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  validates_presence_of :title

  named_scope :latest, {:order => "created_at DESC", :limit => 5}

  def render
    Haml::Engine.new("#{File.dirname(__FILE__)}../views/blogging/show.html.haml").render(self)
  end
  
  def partial
    "/blogging/_#{self.subject_type.downcase}"
  end
end
