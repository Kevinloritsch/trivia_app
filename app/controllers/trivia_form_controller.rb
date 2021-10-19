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
    @inputs = params
    @mutiple_choice_length = get_length_mutiple_choice(@inputs)
    @frq_length = get_length_frq(@inputs)
    question = ""
    for input in inputs
      if(input.includes?("question"))
        question = question + input + "/"+ inputs[input]+ "/";
      end
    end
    
  end
end