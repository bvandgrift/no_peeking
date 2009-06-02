class NoPeekingSetup < ActiveRecord::Migration
  def self.up
    add_column :pages, :no_peeking, :boolean, :default => false
    execute "UPDATE pages SET no_peeking = 0"
  end
  
  def self.down
    remove_column :pages, :no_peeking
  end
end