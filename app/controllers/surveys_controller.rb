# encoding: utf-8
class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params[:id])
  end
end
