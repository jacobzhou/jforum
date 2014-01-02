class CreateSurveyReplies < ActiveRecord::Migration
  def change
    create_table :survey_replies do |t|
      t.integer :survey_user_id
      t.integer :user_id
      t.text :intro
      t.text :point
      t.text :meal
      t.string :title
      t.datetime :send_at
      t.integer :sender_id
      t.timestamps
    end    

    add_index :survey_replies, :survey_user_id
    add_index :survey_replies, :user_id
  end
end
