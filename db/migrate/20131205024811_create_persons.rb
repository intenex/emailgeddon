class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.string :firstname
      t.string :lastname
      t.string :domain

      t.timestamps
    end
  end
end
