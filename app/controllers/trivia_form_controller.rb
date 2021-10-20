class TriviaFormController < ApplicationController
  def trivia_form
  end
  def submit
    def get_length_mutiple_choice(input)
      counter = 0;
      while(true)
        if(counter == 0)
          question_key = "question"
        else
          question_key = "question"+counter.to_s
        end
        if(input[question_key] == nil)
          return counter;
        end
        counter = counter +1
      end
    end
    def get_length_frq(input)
      count = 0;
      while(true)
        question_key = "frqquestion"+count.to_s
        if(input[question_key] == nil)
          return count;
        end
        count = count +1
      end
    end
    def get_questions(inputs)
      questions = ""
      for input in inputs
        if(input.to_s.include?("question"))
          questions = questions + input.to_s + "/";
        end
      end
      return questions
    end
    def get_answers(inputs)
      answers = ""
      for input in inputs
        if(input.to_s.include?("answer"))
          answers = answers+"/" + input.to_s;
        end
      end
      return answers
    end
    def validate(inputs)
      for input in inputs
        for ins in input
          if(ins.to_s.blank?)
            return false;
            break;
          end
        end
      end
      return true;
    end
    @inputs = params
    @validate = "default"
    if(validate(@inputs))
      @validate = "Inputs did validate"
      @questions = get_questions(@inputs);
      @answers = get_answers(@inputs);
      # TriviaGame.create(:question => @questions, :answer => @answers);
    else
      @validate = "Inputs didn't validate"
      redirect_back(fallback_location: root_path)
    end
  end
end