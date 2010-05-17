class Admin::BloggingsController < Admin::ResourceController
  before_filter :allot_subject, :only => :new

  attr_accessor :subject
  helper_method :bloggable_models
  
  def bloggable_models
    ActiveRecord::Base.bloggable_models
  end

protected
  
  def allot_subject
    @blogging.subject_type ||= params[:subject_type]
    @blogging.subject_id ||= params[:subject_id]
  end

end
