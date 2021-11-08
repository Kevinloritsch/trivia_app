class TriviaFormController < ApplicationController
  def trivia_form
  end
  def submit
    @inputs = params
    answer = Array.new
    @everything = Array.new
    for key in @inputs.keys
      if(key.include?("answer"))
        if(key.include?(", 0"))
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
    # def validate(inputs)
    #   def is_blank(inputs)
    #     for input in inputs
    #       for ins in input
    #         if(ins.to_s.blank?)
    #           return false;
    #           break;
    #         end
    #       end
    #     end
    #     return true;
    #   end
    # end
    # if(validate(@inputs))
    #   TriviaGame.create(:data=>@everything.to_s)
    # else
    #   flash[:danger] = "Form field not filled out"
    #   redirect_back(fallback_location: root_path)
    # end
  end
end