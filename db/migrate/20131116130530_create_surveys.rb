class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :desc
      t.timestamps
    end

    create_table :survey_questions do |t|
      t.string :title
      t.integer :survey_id
      t.string :qtype
      t.string :options
      t.string :answers
      t.float :score
      t.string :suf_words
      t.string :ancestry
      t.float :position, :default => 0
      t.timestamps
    end

    create_table :survey_user_sheets do |t|
      t.integer :survey_id
      t.float :score
      t.string :desc
      t.integer :user_id
      t.timestamps
    end

    create_table :survey_user_answers do |t|
      t.integer :survey_user_sheet_id
      t.float :score
      t.string :answers
      t.timestamps
    end    

    add_index :survey_questions, :survey_id
    add_index :survey_user_sheets, :survey_id
    add_index :survey_user_answers, :survey_user_sheet_id
    add_index :survey_user_sheets, :user_id
  end
end
