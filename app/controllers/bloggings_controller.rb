class BloggingsController < SiteController
  helper_method :bloggings, :blog, :blogs
  radiant_layout { |controller| controller.find_a_layout }
  no_login_required

  # delivers designated lists of blog entries with each in the right template type

  def index
    respond_to do |format|
      format.html
      format.js { render :json => bloggings.to_json }
      format.rss { render :layout => false }
    end  
  end
    
  def blogs
    @blogs ||= Blog.all.paginate(pagination_parameters)
  end

  def blog
    @blog ||= Blog.find_by_slug(params[:slug] || "")  # defaults to any blog with an empty slug
  end

  def bloggings
    if blog
      @bloggings ||= blog.bloggings.published.paginate(pagination_parameters)
    else
      @bloggings ||= Blogging.published.paginate(pagination_parameters)
    end
  end
  
  def find_a_layout
    if blog && blog.layout
      blog.layout.name
    else
      layout_for :blogs
    end
  end
  
protected
  

end
