class LotteryLog < ActiveRecord::Base
  MAX_WINNER_COUNT = [5, 2, 3]
  
  def self.winner_in_stage(stage)
    where({stage: stage}).count(:id)
  end
  
  def self.user_can_play?(options)
    fb_uid, fb_email, stage = options[:fb_uid], options[:fb_email], options[:stage]
    if MAX_WINNER_COUNT[(stage-1)] > self.winner_in_stage(stage)
      result = where({
        fb_uid: fb_uid,
        fb_email: fb_email,
        stage: stage
      }).count
      result < 1
    else
      return false
    end
  end
end
