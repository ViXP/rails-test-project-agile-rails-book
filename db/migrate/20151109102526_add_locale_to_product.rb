class AddLocaleToProduct < ActiveRecord::Migration
  def up
  	add_column :products, :locale, :symb, default: :en
  end

  def down
  	remove_column :products, :locale
  end
end
