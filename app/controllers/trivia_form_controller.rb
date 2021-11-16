class TriviaFormController < ApplicationController
  def trivia_form
  end
  def submit
    @inputs = params
    answer = Array.new
    @everything = Array.new
    for key in @inputs.keys
      if(key.include?("answer"))
        if(key.include?(", 0") || key.include?("frq"))
          answer = [key,@inputs[key], true]
          @everything.append(answer);
        else
          answer = [key,@inputs[key], false]
          @everything.append(answer);
        end
      elsif(key.include?("question"))
        answer = [key, @inputs[key]]
        @everything.append(answer);
      end
    end
    def is_blank(array)
      for index in 0..(array.length()-1)
        counter = 0;
        for input in array[index]
          if(input != false && input.blank?)
            return index;
          end
          counter = counter + 1;
        end
      end
      return true;
    end
    def check_answer_choice(array)
      storage = Array.new
      for index in 0..(array.length()-1)
        if(array[index].to_s.include?("answer") && !array[index].to_s.include?("frq"))
          storage.append(array[index])
        end
      end
      counter = 0
      for count in 0..(storage.length()-1)
        if(storage[count][2])
          counter = counter + 1
        end
        if((count+1)%4 == 0 and count != 0)
          if(counter > 0)
            counter = 0
          elsif(counter == 0)
            return storage[count]
          end
        end
      end
      return true
    end
    @x = is_blank(@everything)
    if(@x.class == Integer)
      if(@x%5 == 0)
        flash[:danger] = "Question " + ((@x/5)+1).to_s + " has not filled out!"
      else
        flash[:danger] = "Question " + (@x/5+1).to_s + "\tAnswer " + ((@x%5)).to_s + " is not filled out"
      end
      redirect_back(fallback_location: root_path)
    end
    @valid = check_answer_choice(@everything)
    if(@valid.class == Array)
      question_number = (@valid[0][-1].to_i + 1).to_s
      flash[:danger] = "Question" + question_number + " does not have an answer!"
      redirect_back(fallback_location: root_path)
    end

    # if(validate(@inputs))
    #   TriviaGame.create(:data=>@everything.to_s)
    # else
    #   flash[:danger] = "Form field not filled out"
    #   redirect_back(fallback_location: root_path)
    # end
  end
end