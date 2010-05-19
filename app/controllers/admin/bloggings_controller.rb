class Admin::BloggingsController < Admin::ResourceController
  before_filter :preselect_subject, :only => :new
  prepend_before_filter :eliminate_unselected_fields, :only => [:create, :update]

  attr_accessor :subject
  helper_method :bloggable_models
  
  def bloggable_models
    ActiveRecord::Base.bloggable_models
  end
  
protected
  
  def preselect_subject
    unless params[:subject_type].blank?
      @blogging.subject_type ||= params[:subject_type].titlecase
      @blogging.subject_id ||= params[:subject_id]
    end
  end

  # the build_subject method in Bloggable will use use the subject_attributes to build the right kind of object
  # here we get rid of any unselected input that remains in the form and move the selected input into subject_attributes
  
  def eliminate_unselected_fields
    if params[:blogging] && type = params[:blogging][:subject_type]
      label = type.to_s.downcase
      params[:blogging][:subject_attributes] = params[:blogging][label.to_sym] || {}
      params[:blogging][:subject_attributes][:id] = params[:blogging]["#{label}_id".to_sym]
      params[:blogging][:subject_id] = params[:blogging]["#{label}_id".to_sym]
      unless params[:blogging][:subject_attributes][:id] 
        params[:blogging][:subject_attributes][:subject_type] = type                            # passes the type through to build_subject
      end
    end
    bloggable_models.each do |exclude|
      params[:blogging].delete(exclude)
      params[:blogging].delete("#{exclude}_id".to_sym)
    end
  end
end
