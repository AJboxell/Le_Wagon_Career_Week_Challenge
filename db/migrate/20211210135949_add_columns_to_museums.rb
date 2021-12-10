class AddColumnsToMuseums < ActiveRecord::Migration[6.0]
  def change
    add_column :museums, :name, :string
    add_column :museums, :postcode, :string
  end
end
