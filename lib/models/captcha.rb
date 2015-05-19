# -*- encoding : utf-8 -*-
require 'open-uri'

class Captcha < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :user

  before_create :set_content_and_expired_at
  after_create :send_sms

  scope :generate, ->(use_for) { self.create({ use_for: use_for }) }
  scope :available, -> { where(available: true) }
  scope :today, -> { where('created_at >= ?', Time.now.beginning_of_day).where('created_at <= ?', Time.now.end_of_day) }

  def expire!
    self.update({ available: false })
  end

  protected
  def set_content_and_expired_at
    self.content = rand(1234..9876)
    self.expired_at = Time.now + 30.minutes
  end

  def send_sms
    self.user.send_sms("校验码：#{self.content}，请勿将此校验码泄露给他人。")
  end
end
