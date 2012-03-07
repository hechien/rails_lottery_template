class HomeController < ApplicationController
  CURRENT_STAGE = 1
  def index
  end

  def play
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
    end
  end
  
  private
  def roll_the_dice
    rand * 200 < 10
  end
end
