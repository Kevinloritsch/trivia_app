class TriviaFormController < ApplicationController
  def trivia_form
  end
  def submit
    @message = params[:question]
  end
end
