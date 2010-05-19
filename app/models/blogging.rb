class Blogging < ActiveRecord::Base
  has_site if respond_to? :has_site
  belongs_to :blog
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :subject, :polymorphic => true
  accepts_nested_attributes_for :subject
  before_save :set_blog, :update_status

  named_scope :latest, {:limit => 5}
  named_scope :published, {:order => "published_at DESC", :conditions => ["status_id >= :published", {:published => Status[:published].id}]}
  
  def publication_date
    published_at.to_datetime.strftime(date_format) if published_at 
  end

  def creation_date
    created_at.to_datetime.strftime(date_format) if created_at 
  end
  
  def date_format
    "%-1d %B %Y"
  end
  
  def published?
    status == Status[:published]
  end
  
  def status
   Status.find(self.status_id)
  end
  
  def status=(value)
    self.status_id = value.id
  end

  def build_subject(params)
    if type = params.delete(:subject_type)
      self.subject = type.to_s.titlecase.constantize.new
      self.subject.attributes = params
    end
  end

  def update_status
    self[:published_at] = Time.now if self[:status_id] == Status[:published].id && self[:published_at] == nil
    if self[:published_at] != nil && (self[:status_id] == Status[:published].id || self[:status_id] == Status[:scheduled].id)
      self[:status_id] = Status[:scheduled].id if self[:published_at]  > Time.now
      self[:status_id] = Status[:published].id if self[:published_at] <= Time.now
    end
    true    
  end

protected
  def set_blog
    self.blog ||= Blog.default
  end
end
