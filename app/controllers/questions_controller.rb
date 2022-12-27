class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]
  after_action :publish_question, only: :create

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answers = @question.answers.all
    @answer.links.new

    gon.push({current_user: current_user})
    gon.push({question_id: @question.id})
  end

  def new
    @question = Question.new
    @question.links.new
    @award = Award.new(question: @question)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Your question successfully deleted"
  end

  private

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], 
                                                    links_attributes: [:name, :url],
                                                    award_attributes: [:title, :image])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast(
      "questions",
      {
        partial: ApplicationController.render(
          partial: "questions/question",
          locals: { question: @question, current_user: current_user }
        )
      }
    )
  end
end
