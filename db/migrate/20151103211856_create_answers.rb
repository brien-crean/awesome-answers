class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # the references type in here tells Rails to generate an integer field
      # called 'question_id' (this is a Rails convention, model name underscored with _id after it)
      # foreign_key: is a column in a table that references an id for a row in another tables.
      # So question_id is in the answers table but if references 'id' of a row in the questions table
      # foreign_key: true option will add a foreign key constraint in the DB
      t.references :question, index: true, foreign_key: true

      # index true option adds an index on the question_id field and this recommended because we will likely execute many
      # queries that find all the answers for a specific question so we will be finding answers by their question_id
      # so its best to have that column indexed - uses binary tree

      t.timestamps null: false
    end
  end
end
