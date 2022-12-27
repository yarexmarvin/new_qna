class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
