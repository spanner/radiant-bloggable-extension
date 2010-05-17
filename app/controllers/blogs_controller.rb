class BlogsController < SiteController
  helper_method :blogs, :blog, :bloggings
  radiant_layout { |controller| controller.find_a_layout }
  no_login_required

  # delivers designated lists of blog entries with each in the right template type

  def index
    respond_to do |format|
      format.html
      format.js { render :json => blogs.to_json }
      format.rss { render :layout => false }
    end  
  end
  
  def show
    respond_to do |format|
      format.html
      format.js { render :json => bloggings.to_json }
      format.rss { render :layout => false }
    end  
  end
  
  def blogs
    @blogs ||= Blog.all.paginated(pagination_options)
  end

  def blog
    if params[:slug]
      @blog ||= Blog.find_by_slug(params[:slug]).paginated(pagination_options)
    end
  end

  def bloggings
    if blog
      @bloggings = blog.bloggings.paginated(pagination_options)
    else
      @bloggings = Blogging.all.paginated(pagination_options)
    end
  end
  
protected
  
  def find_a_layout
    if blog && blog.layout
      blog.layout.title
    else
      layout_for :blogs
    end
  end

end
