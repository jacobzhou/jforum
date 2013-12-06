# encoding: utf-8
class Admin::SurveyQuestionsController < Admin::BaseController
  def index
    @survey_questions = SurveyQuestion.all.to_sorted_nodes
  end

  def new
    @survey_question = SurveyQuestion.new(:parent_id => params[:parent_id])  
    render :layout => false
  end

  def create
    @survey_question = SurveyQuestion.new(params[:survey_question])
    flash_msg(:success) if @survey_question.save
    respond_back(@survey_question)
  end

  def edit
    render :layout=>false
  end

  def update
    flash_msg(:success) if @survey_question.update_attributes(params[:survey_question])
    respond_back(@survey_question)
  end

  def destroy
    if @survey_question.destroy
      respond_to do |format|
        flash_msg(:success) 
        format.html{respond_back(@survey_question)}
        format.json{render :json => true}
        # format.json{render :json => {status:'success'}}
      end
    end
  end
end
