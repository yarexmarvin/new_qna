class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show best]
  before_action :find_answer, only: %i[show edit update destroy best]
  before_action :find_question, only: %i[new create]

  def show; end

  def new
    @answer = @question.answers.new
    @answer.links.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def edit; end

  def update
    @question = @answer.question
    @answer.update(answer_params)
  end

  def best
    @question = @answer.question
    @answer.set_the_best if current_user.author_of?(@question)
  end

  def destroy
    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], 
                                          links_attributes: [:name, :url], 
                                          award_attributes: [:title, :image])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end
end
