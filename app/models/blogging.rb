class Blogging < ActiveRecord::Base
  has_site if respond_to? :has_site
  belongs_to :blog
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :subject, :polymorphic => true
  accepts_nested_attributes_for :subject

  named_scope :latest, {:order => "created_at DESC", :limit => 5}

  def render
    Haml::Engine.new("#{File.dirname(__FILE__)}../views/blogging/show.html.haml").render(self)
  end
  
  def partial
    "/blogging/_#{self.subject_type.downcase}"
  end
  
  def build_subject(params)
    if type = params.delete(:subject_type)
      self.subject = type.to_s.titlecase.constantize.new
      self.subject.attributes = params
    end
  end
  
end
