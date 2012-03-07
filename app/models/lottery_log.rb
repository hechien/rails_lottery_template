class LotteryLog < ActiveRecord::Base
  
  def self.user_can_play?(options)
    fb_uid, fb_email, stage = options[:fb_uid], options[:fb_email], options[:stage]
    result = where({
      fb_uid: fb_uid,
      fb_email: fb_email,
      stage: stage
    }).count
    result < 1
  end
end
