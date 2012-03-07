class HomeController < ApplicationController
  CURRENT_STAGE = 1
  def index
  end

  def play
    params[:options].merge!({stage: CURRENT_STAGE})
    if LotteryLog.user_can_play?(params[:options])
      options = params[:options]
      # Random
      result = roll_the_dice
      LotteryLog.create({
        fb_uid: options[:fb_uid],
        fb_email: options[:fb_email],
        stage: CURRENT_STAGE,
        win: result
      })
      
      respond_to do |f|
        f.json { render json: {win: result}.as_json }
      end
    else
      respond_to do |f|
        f.js{ render "already_played" }
      end
    end
  end
  
  private
  def roll_the_dice
    rand * 200 < 10
  end
end
