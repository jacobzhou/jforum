class CreateSurveys < ActiveRecord::Migration
  def change
    # create_table :surveys do |t|
    #   t.string :name
    #   t.string :desc
    #   t.timestamps
    # end

    # create_table :survey_questions do |t|
    #   t.string :title
    #   t.integer :survey_id
    #   t.string :qtype
    #   t.text :options
    #   t.string :answers
    #   t.float :score
    #   t.string :suf_words
    #   t.string :ancestry
    #   t.float :position, :default => 0
    #   t.timestamps
    # end

    # create_table :survey_user_sheets do |t|
    #   t.integer :survey_id
    #   t.float :score
    #   t.string :desc
    #   t.integer :user_id
    #   t.timestamps
    # end

    # create_table :survey_user_answers do |t|
    #   t.integer :survey_user_sheet_id
    #   t.float :score
    #   t.string :answers
    #   t.timestamps
    # end    

    # add_index :survey_questions, :survey_id
    # add_index :survey_user_sheets, :survey_id
    # add_index :survey_user_answers, :survey_user_sheet_id
    # add_index :survey_user_sheets, :user_id
    create_table :survey_notices do |t|
      t.integer :user_id
      t.integer :noticer_id
      t.integer :survey_id
      t.integer :survey_question_id
      t.integer :status, :limit => 2, :default => 0
      t.timestamps
    end   
    add_index :survey_notices, :user_id
    add_index :survey_notices, :survey_question_id
    add_index :survey_notices, :status
  end
end
