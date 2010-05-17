class EmbedType < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :template
  has_many :embeds

  def to_s
    
  end
end
