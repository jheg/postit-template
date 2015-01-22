class FixTypoCatIdPostCategoris < ActiveRecord::Migration
  def change
    remove_column :post_categories, :catergory_id, :integer
    add_column :post_categories, :category_id, :integer
  end
end
