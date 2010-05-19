class BlogData < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.column :title, :string
      t.column :slug, :string
      t.column :introduction, :text
      t.column :layout_id, :integer
      t.column :site_id, :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :lock_version, :integer
    end
    
    create_table :bloggings do |t|
      t.column :title, :string
      t.column :url, :text
      t.column :body, :text
      t.column :presentation, :string
      t.column :blog_id, :integer
      t.column :subject_type, :string
      t.column :subject_id, :integer
      t.column :site_id, :integer
      t.column :status_id, :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :published_at, :datetime
      t.column :lock_version, :integer
    end
    add_index :bloggings, :blog_id

    create_table :quotes do |t|
      t.column :body, :text
      t.column :speaker, :string
      t.column :url, :string
      t.column :site_id, :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :lock_version, :integer
    end
    
    create_table :embeds do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :url, :string
      t.column :site_id, :integer
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :lock_version, :integer
    end
  end

  def self.down
    drop_table :blogs
    drop_table :bloggings
    drop_table :blog_quotes
    drop_table :blog_embeds
    drop_table :blog_embed_types
  end
end
