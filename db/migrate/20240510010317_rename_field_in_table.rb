class RenameFieldInTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :pokemons, :legenday, :legendary
  end
end
