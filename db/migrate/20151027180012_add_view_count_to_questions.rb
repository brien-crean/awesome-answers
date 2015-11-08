class AddViewCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :view_count, :integer
    # remove_column :questions, :view_count, :integer - to remove a column
    # would need to run another migration for the change to take effect
  end
end
