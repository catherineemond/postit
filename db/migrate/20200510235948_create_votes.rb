class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.references :votable, polymorphic: true
      t.timestamps
    end
  end
end
