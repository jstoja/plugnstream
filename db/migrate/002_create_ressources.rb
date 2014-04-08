class CreateRessources < ActiveRecord::Migration
  def self.up
    create_table :ressources do |t|
      #t.column :id, :number, :null => false
      t.column :ip_address, :string, :null => false
      t.column :type, :string, :null => false
      t.column :occupied, :boolean, :null => false, :default => false
      t.column :exist, :boolean, :null => false, :default => true

      t.timestamps
    end

    add_index :ressources, :id, { unique: true }
  end
 
  def self.down
    drop_table :ressources
  end
end