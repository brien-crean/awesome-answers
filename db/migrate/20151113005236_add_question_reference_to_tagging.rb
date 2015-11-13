class AddQuestionReferenceToTagging < ActiveRecord::Migration
  def change
    add_reference :taggings, :question, index: true, foreign_key: true
  end
end
