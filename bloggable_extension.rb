# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class BloggableExtension < Radiant::Extension
  version "1.0"
  description "A blog-by-reference engine for radiant"
  url "http://radiant.spanner.org/bloggable"
  
  def activate
    ActiveRecord::Base.send :include, BloggableModel                     # provide is_bloggable method but don't call it yet
    Page.send :is_bloggable                                              # pages can be blogged about
    Asset.send :is_bloggable if defined? Asset                           # if paperclipped is installed, assets can be blogged about
    Event.send :is_bloggable if defined? Event                           # if event_calendar is installed, events can be blogged about
    UserActionObserver.instance.send :add_observer!, Blog                # adds ownership and update hooks
    UserActionObserver.instance.send :add_observer!, Blogging               
    UserActionObserver.instance.send :add_observer!, Quote               
    UserActionObserver.instance.send :add_observer!, Embed               

    unless defined? admin.blog
      Radiant::AdminUI.send :include, BloggableAdminUI
      admin.blog = Radiant::AdminUI.load_default_blog_regions
      admin.blogging = Radiant::AdminUI.load_default_blogging_regions
    end
    
    tab 'Content' do
      add_item "Blog", "/admin/blog", :after => "Pages"
    end
  end
end
