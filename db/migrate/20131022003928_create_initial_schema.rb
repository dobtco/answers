class CreateInitialSchema < ActiveRecord::Migration
  def change

    create_table "active_admin_comments", :force => true do |t|
      t.string   "resource_id",   :null => false
      t.string   "resource_type", :null => false
      t.integer  "author_id"
      t.string   "author_type"
      t.text     "body"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
      t.string   "namespace"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
    add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
    add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

    create_table "articles", :force => true do |t|
      t.datetime "updated"
      t.string   "title"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
      t.string   "content_type"
      t.text     "preview"
      t.integer  "contact_id"
      t.text     "tags"
      t.string   "service_url"
      t.string   "slug"
      t.integer  "category_id"
      t.integer  "access_count",            :default => 0
      t.string   "author_pic_file_name"
      t.string   "author_pic_content_type"
      t.integer  "author_pic_file_size"
      t.datetime "author_pic_updated_at"
      t.string   "author_name"
      t.string   "author_link"
      t.string   "type"
      t.text     "content_main"
      t.text     "content_main_extra"
      t.text     "content_need_to_know"
      t.integer  "user_id"
      t.boolean  "published"
      t.boolean  "pending_review"
    end

    add_index "articles", ["slug"], :name => "index_articles_on_slug"
    add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

    create_table "categories", :force => true do |t|
      t.string   "name"
      t.integer  "access_count"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.integer  "article_id"
      t.text     "description"
      t.string   "slug"
    end

    add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

    create_table "contacts", :force => true do |t|
      t.string   "name"
      t.string   "subname"
      t.string   "number"
      t.string   "url"
      t.string   "address"
      t.string   "department"
      t.text     "description"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end

    create_table "delayed_jobs", :force => true do |t|
      t.integer  "priority",   :default => 0
      t.integer  "attempts",   :default => 0
      t.text     "handler"
      t.text     "last_error"
      t.datetime "run_at"
      t.datetime "locked_at"
      t.datetime "failed_at"
      t.string   "locked_by"
      t.string   "queue"
      t.datetime "created_at",                :null => false
      t.datetime "updated_at",                :null => false
    end

    add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

    create_table "departments", :force => true do |t|
      t.string   "name"
      t.string   "acronym"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "friendly_id_slugs", :force => true do |t|
      t.string   "slug",                         :null => false
      t.integer  "sluggable_id",                 :null => false
      t.string   "sluggable_type", :limit => 40
      t.datetime "created_at"
    end

    add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
    add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
    add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

    create_table "guide_steps", :force => true do |t|
      t.integer  "article_id"
      t.string   "title"
      t.text     "content"
      t.text     "preview"
      t.integer  "step"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "keywords", :force => true do |t|
      t.string   "name"
      t.string   "metaphone"
      t.string   "stem"
      t.text     "synonyms"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "rails_admin_histories", :force => true do |t|
      t.text     "message"
      t.string   "username"
      t.integer  "item"
      t.string   "table"
      t.integer  "month",      :limit => 2
      t.integer  "year",       :limit => 8
      t.datetime "created_at",              :null => false
      t.datetime "updated_at",              :null => false
    end

    add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

    create_table "sites", :force => true do |t|
      t.integer "dobt_organization_app_id"
      t.string  "name"
      t.string  "username"
      t.string  "custom_domain"
    end

    create_table "wordcounts", :force => true do |t|
      t.integer  "article_id"
      t.integer  "keyword_id"
      t.integer  "count"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

  end
end
