class Blogging < ActiveRecord::Base
  has_site if respond_to? :has_site
  belongs_to :blog
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :subject, :polymorphic => true
  accepts_nested_attributes_for :subject
  before_save :set_blog
  named_scope :latest, {:order => "created_at DESC", :limit => 5}
  
  def date
    created_at.to_datetime.strftime("%-1d %B %Y")
  end
  
  def build_subject(params)
    if type = params.delete(:subject_type)
      self.subject = type.to_s.titlecase.constantize.new
      self.subject.attributes = params
    end
  end

protected
  def set_blog
    self.blog ||= Blog.default
  end
end
