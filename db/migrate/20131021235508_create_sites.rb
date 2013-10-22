class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :dobt_organization_app_id
      t.string :name
      t.string :username
      t.string :custom_domain
    end
  end
end
