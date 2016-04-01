class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
        
    if @question.save
        redirect_to @question, notice: "Question was saved successfully."
    else
        flash.now[:alert] = "Error creating question. Please try again."
        render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    @question.assign_attributes(question_params)

    if @question.save
      flash[:notice] = "Question was updated."
      redirect_to @question
    else
      flash.now[:alert] = "Error saving question. Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    
    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the question."
      render :show
    end
  end



# remember to add private methods to the bottom of the file. Any method defined below private, will be private.
  private
 
  def question_params
    params.require(:question).permit(:title, :body, :resolved)
  end
end