class RemoveNameFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :name
  end
end
