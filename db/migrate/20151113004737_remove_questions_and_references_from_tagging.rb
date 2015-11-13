class RemoveQuestionsAndReferencesFromTagging < ActiveRecord::Migration
  def change
    remove_column :taggings, :question, :string
    remove_column :taggings, :references, :string
  end
end
