class CreateQuestions < ActiveRecord::Migration
  def change
    # The DSL Somain Specifc Language is a ruby code with special methods that enables us to acheive a specific task
    # In this case teh DSL for migrations enables use to create / drop tables
    create_table :questions do |t|

      # we dont need to specifiy 'id' field because Rails will auto create
      #an id field that is integer, primary key and autoincrement

      t.string :title # this will create VARCHAR column in the DB
      t.text :body # this will create TEXT column in the DB

      t.timestamps null: false # this will create 2 timestamp columns in DB
                               # one is "created_at" the other is "updated_at"
    end
  end
end
