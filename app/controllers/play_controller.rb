class PlayController < ApplicationController
    def index
        render plain: params["room_id"]
    end
end