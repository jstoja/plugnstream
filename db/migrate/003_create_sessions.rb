class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      #t.column :id, :number, :null => false
      t.column :user_id, :number, :null => false
      t.column :server_id, :number, :null => false
      t.column :time_start, :timestamp, :null => false
      t.column :time_end, :timestamp, :null => false
      t.column :token, :string, :null => false

      t.timestamps
    end

    add_index :sessions, :id, { unique: true }
  end
 
  def self.down
    drop_table :sessions
  end
end