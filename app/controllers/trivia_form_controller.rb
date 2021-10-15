class TriviaFormController < ApplicationController
  def trivia_form
  end
  def submit
    @question = params
    # @answer_a = params[:a]
    # @answer_b = params[:b]
    # @answer_c = params[:c]
    # @answer_d = params[:d]
    puts(params[:question])
  end
end
