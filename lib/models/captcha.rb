# -*- encoding : utf-8 -*-
require 'open-uri'

class Captcha < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :user

  before_create :set_content_and_expired_at

  scope :generate, ->(use_for) { self.create({ use_for: use_for }) }
  scope :available, -> { where(available: true) }
  scope :today, -> { where('created_at >= ?', Time.now.beginning_of_day).where('created_at <= ?', Time.now.end_of_day) }

  def expire!
    self.update({ available: false })
  end

  protected
  def set_content_and_expired_at
    last_captcha = self.user.captchas.order(created_at: :desc).first
    if last_captcha.present? and last_captcha.available==1 and Time.now.utc<last_captcha.expired_at
          self.content = last_captcha.content
    else
          self.content = rand(1234..9876)
    end
    self.expired_at = Time.now + 30.minutes
  end

end
