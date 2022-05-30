class TriviaFormController < ApplicationController
  before_action :logged_in_user
  # skip_before_filter :verify_authenticity_token  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Log In."
      redirect_to login_url
   end
end
  def trivia_form
  end
  def submit
    # puts(params);
    @inputs = params
    answer = Array.new
    @everything = Array.new
    for key in @inputs.keys
      if(key.include?("answer"))
        if(key.include?(", 0") || key.include?("frq"))
          answer = [key,@inputs[key].to_s, true]
          @everything.append(answer);
        else
          answer = [key,@inputs[key].to_s, false]
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
            return [index,array[index]];
          end
          counter = counter + 1;
        end
      end
      return [true];
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
    def question_length(array)
      mutiple_choice_counter = 0;
      frq_counter = 0;
      for count in 0..(array.length()-1)
        if(array[count].to_s.include?("question") and !array[count].to_s.include?("frq"))
          mutiple_choice_counter = mutiple_choice_counter +1
        elsif(array[count].to_s.include?("frq") and array[count].to_s.include?("question"))
          frq_counter = frq_counter +1;
        end
      end
      return [mutiple_choice_counter+frq_counter];
    end
    def get_mutiple_choice(array)
      mutiplechoice = Array.new
      for index in 0..(array.length()-1)
        if((array[index].to_s.include?("answer") || array[index].to_s.include?("question")) && !array[index].to_s.include?("frq"))
          mutiplechoice.append(array[index])
        end
      end
      return mutiplechoice;
    end
    def get_frq(array)
      frq = Array.new
      for index in 0..(array.length()-1)
        if(array[index].to_s.include?("frq"))
          frq.append(array[index])
        end
      end
      return frq
    end
    if(params["title"] == nil.to_s)
      flash[:danger] = "Title is not filled out!"
      for key in @inputs.keys
        if(key.include?("id"))
          redirect_to edit_user_trivia_game_path(:everything => @everything.to_s, :id => params["id"].to_i, :user_id => params["user_id"], :title => params["title"]) and return;
        end
      end
      redirect_to create_path(:everything => @everything.to_s, :question_length => question_length(@everything)[0],:title => params["title"]) and return
    end
    @x = is_blank(@everything)
    if(@x[0].class == Integer)
      if(@x[1][0].include?("question"))
        flash[:danger] = "Question "+ (@x[1][0][-1].to_i).to_s + " is not filled out!"
      elsif(@x[1][0].include?("frq"))
        flash[:danger] = "Question " + (@x[1][0][-1].to_i).to_s + "\tAnswer is not filled out!"
      else
        if(@x[1][0].include?("answera"))
          flash[:danger] = "Question " + (@x[1][0][-1].to_i).to_s + "\tAnswer A is not filled out!"
        elsif(@x[1][0].include?("answerb"))
          flash[:danger] = "Question " + (@x[1][0][-1].to_i).to_s + "\tAnswer B is not filled out!"
        elsif(@x[1][0].include?("answerc"))
          flash[:danger] = "Question " + (@x[1][0][-1].to_i).to_s + "\tAnswer C is not filled out!"
        elsif(@x[1][0].include?("answerd"))
          flash[:danger] = "Question " + (@x[1][0][-1].to_i).to_s + "\tAnswer D is not filled out!"
        end
      end
      for key in @inputs.keys
        if(key.include?("id"))
          redirect_to edit_user_trivia_game_path(:everything => @everything.to_s, :id => params["id"].to_i, :user_id => params["user_id"], :title=> params["title"]) and return;
        end
      end
      redirect_to create_path(:everything => @everything.to_s, :question_length => question_length(@everything)[0],:title => params["title"]) and return
    end
    @valid = check_answer_choice(@everything)
    if(@valid.class == Array)
      question_number = (@valid[0][-1].to_i + 1).to_s
      flash[:danger] = "Question" + question_number + " does not have an answer!"
      for key in @inputs.keys
        if(key.include?("id"))
          redirect_to edit_user_trivia_game_path(:everything => @everything.to_s, :id => params["id"].to_i, :user_id => params["user_id"],:title => params["title"]) and return;
        end
      end
      redirect_to create_path(:everything => @everything.to_s, :question_length => question_length(@everything)[0], :title=> params["title"],:title => params["title"]) and return
    end
    for key in @inputs.keys
      if(key.include?("id"))
        user = User.find_by(id: params["user_id"])
        trivia_games = Array.new;
        TriviaGame.where(author: user.email).find_each do |trivia_game|
            trivia_games.append(trivia_game);
        end
        trivia_game = trivia_games[params["id"].to_i]
        trivia_game.data = @everything
        trivia_game.title = params["title"].to_s
        trivia_game.save
        return redirect_to(current_user)
      end
    end
    TriviaGame.create(:data=>@everything.to_s, :author=>current_user.email, :title=>params["title"])
  end
end