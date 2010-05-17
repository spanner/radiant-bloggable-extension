module BloggableAdminUI

 def self.included(base)
   base.class_eval do

      attr_accessor :blog
      alias_method :blogs, :blog
      attr_accessor :blogging
      alias_method :bloggings, :blogging

      def load_default_regions_with_blogs
        load_default_regions_without_blogs
        @blog = load_default_blog_regions
        @blogging = load_default_blogging_regions
      end

      alias_method_chain :load_default_regions, :blogs

    protected

      def load_default_blog_regions
        returning OpenStruct.new do |blog|
          blog.edit = Radiant::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{edit_header edit_form}
            edit.form.concat %w{edit_title edit_slug edit_introduction}
            edit.form_bottom.concat %w{edit_timestamp edit_buttons}
          end
          blog.index = Radiant::AdminUI::RegionSet.new do |index|
            index.thead.concat %w{title_header introduction_header contents_header modify_header}
            index.tbody.concat %w{title_cell introduction_cell contents_cell modify_cell}
            index.bottom.concat %w{buttons}
          end
          blog.remove = blog.index
          blog.new = blog.edit
        end
      end

      def load_default_blogging_regions
        returning OpenStruct.new do |blogging|
          blogging.edit = Radiant::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{edit_header edit_form}
            edit.form.concat %w{edit_subject edit_text preview}
            edit.form_bottom.concat %w{edit_timestamp edit_buttons}
          end
          blogging.index = Radiant::AdminUI::RegionSet.new do |index|
            index.thead.concat %w{title_header subject_header body_header modify_header}
            index.tbody.concat %w{title_cell subject_cell body_cell modify_cell}
            index.bottom.concat %w{buttons}
          end
          blogging.remove = blogging.index
          blogging.new = blogging.edit
        end
      end
      
    end
  end
end

