class CreateSurveyReplies < ActiveRecord::Migration
  def change
    create_table :survey_replies do |t|
      t.integer :survey_user_id
      t.integer :user_id
      t.text :intro
      t.text :point
      t.text :meal
      t.string :title
      t.text :zc_zc, :limit => 4294967295
      t.text :zc_zwc, :limit => 4294967295
      t.text :zc_sg, :limit => 4294967295
      t.text :zc_sc, :limit => 4294967295
      t.text :zc_gw, :limit => 4294967295
      t.strign :jc
      t.datetime :send_at
      t.integer :sender_id
      t.timestamps
    end    

    add_index :survey_replies, :survey_user_id
    add_index :survey_replies, :user_id
  end
end
