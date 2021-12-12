class TriviaGamesController < ApplicationController
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please Log In."
          redirect_to login_url
       end
    end
    def index
        redirect_to(current_user)
    end
    def show
        user = User.find_by(id: params["user_id"].to_i)
        trivia_games = Array.new;
        if(params["destroy"].to_s == 'true')
            TriviaGame.where(author: user.email).find_each do |trivia_game|
                trivia_games.append(trivia_game);
            end
        end
        trivia_games[params["id"].to_i].destroy
        return redirect_to(current_user)
    end
    def edit
        user_id = nil;
        @trivia_game_index  = nil;
        for key in params.keys
            if(key.to_s == 'user_id')
                user_id = params[key]
            elsif(key.to_s == "id")
                @trivia_game_index = params[key]
            end
        end
        user = User.find_by(id: user_id.to_i)
        @trivia_games = Array.new;
        TriviaGame.where(author: user.email).find_each do |trivia_game|
            @trivia_games.append(trivia_game);
        end
        @trivia_game = @trivia_games[@trivia_game_index.to_i]
    end
    def update
        redirect_to(current_user)
    end

end