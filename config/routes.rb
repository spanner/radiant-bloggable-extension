EXT_ROOT = '/admin/blog'

ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :path_prefix => EXT_ROOT do |admin|
    admin.resources :blogs, :has_many => :bloggings, :member => { :remove => :get }
    admin.resources :bloggings
    admin.blog_about "about/:subject_type/:subject_id", :controller => 'bloggings', :action => 'new'
    admin.blog_home '/', :controller => 'bloggings', :action => 'index'
  end
end