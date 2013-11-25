# encoding: utf-8
class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params[:id])
    @survey_questions = @survey.survey_questions
  end
end
