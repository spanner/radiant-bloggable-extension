module BloggableModel      # for inclusion into ActiveRecord::Base
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval {
      @@bloggable_models = []
      cattr_accessor :bloggable_models
    }
  end

  module ClassMethods
    def is_bloggable?
      false
    end

    def is_bloggable(options={})
      return if is_bloggable?

      has_many :bloggings, :as => :subject
      
      class_eval {
        extend BloggableModel::BloggableClassMethods
        include BloggableModel::BloggableInstanceMethods
      }

      ActiveRecord::Base.bloggable_models.push(self.to_s.downcase.intern)
    end
  end

  module BloggableClassMethods
    def is_bloggable?
      true
    end
  end
  
  module BloggableInstanceMethods
    
  end
end

