class CreateUsers < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"

    create_table :users do |t|
      t.integer :dobt_user_id
      t.hstore :profile
      t.text :organizations
      t.boolean :needs_remote_refresh, default: false
      t.string :local_remember_token
      t.string :global_remember_token

      t.timestamps
    end

    add_index :users, :dobt_user_id
    add_index :users, :local_remember_token
    add_index :users, :global_remember_token
  end
end
