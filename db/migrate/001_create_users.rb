class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      #t.column :id, :number, :null => false
      t.column :name, :string, :null => false
      t.column :mail, :string, :null => false
      t.column :password, :string, :null => false
      t.column :password_salt, :string, :null => false
      t.column :token_salt, :string, :null => false
      t.column :level, :integer, :default => 0

      t.timestamps
    end

    add_index :users, :id, { unique: true }
  end
 
  def self.down
    drop_table :users
  end
end