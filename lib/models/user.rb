# -*- encoding : utf-8 -*-
require 'aliyun/mns'

class User < ActiveRecord::Base
  include UUID
  include AASM
  extend Sunspot::Rails::Searchable::ActsAsMethods

  self.table_name_prefix = ''

  mount_uploader :image, UserUploader

  def nick
    self.nickname
  end

  has_many :captchas
  has_many :tokens
  has_many :trade_records
  has_many :followings, class_name: 'Followship'
  has_many :messages
  has_many :api_followings, class_name: 'Match::Followship'
  has_many :questions
  has_many :api_questions, class_name: 'Asking::Question'
  has_many :answers
  has_many :api_answers, class_name: 'Asking::Answer'
  has_many :collects
  has_many :api_collects, class_name: 'News::Collect'
  has_many :orders
  has_many :api_orders, class_name: 'Booking::Order'
  belongs_to :phone_area

  aasm column: 'state' do
    state :validating, :initial => true
    state :available
    state :prohibited

    event :signup, after: :set_signuped_at! do
      transitions from: :validating, to: :available
    end
    event :prohibit do
      transitions from: :available, to: :prohibited
    end
  end

  # searchable do
  #   text :uuid, :phone, :email, :nickname, :description
  # end
  #before_create :hash_password_and_set_token

  validates :phone, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 36 }
  validates :email, length: { in: 6..100 }, unless: "email.blank?"
  validates :handicap, length: { in: 1..3 }, unless: "handicap.blank?"

  def authenticate password
    self.hashed_password == Digest::MD5.hexdigest(password) ? self : nil
  end

  def update_password password
    self.update(hashed_password: Digest::MD5.hexdigest(password))
  end

  def set_signuped_at!
    self.update({ signuped_at: Time.now })
  end

  def signin!
    self.update({ last_signined_at: self.current_signined_at, current_signined_at: Time.now})
  end

  def authenticate token
    valid_token = self.tokens.available
    if valid_token
      if valid_token.content == token
        true
      else
        false
      end
    else
      false
    end
  end

  def follow competitor
    raise FollowDuplicated unless self.api_followings.create({ competitor: competitor }).id
  end

  def unfollow competitor
    raise InexistentFollowship unless self.api_followings.where({ competitor: competitor }).first.try(&:destroy)
  end

  def send_push options = {}, priority = 8
    raise ArgumentError, "Invalid arguments：priority value in (1..16), default value is 8." unless (1..16) === priority
    message = { to: :user, cid: self.cid }.merge!(options)
    Aliyun::Mns::Queue[ENV['PUSH_QUEUE']].send_message(message.to_json, :Priority=>priority)
  end

  def send_sms message, priority = 8
    raise ArgumentError, "Invalid arguments：priority value in (1..16), default value is 8." unless (1..16) === priority
    message_hash = { function: "sms", to: phone, data: message}
    Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json, :Priority=>priority)
  end

  def send_captcha_sms captcha
    message_hash = { function: "cpc_sms", to: self.phone, data:[captcha]}
    Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json)
  end

  def send_captcha_voice captcha
    message_hash = { function: "cpc_voice", to: self.phone, data:[captcha]}
    Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json)
  end

  class << self
    def find_or_create phone
      self.where(phone: phone).first || self.create({ phone: phone, nickname: "用户****#{phone[-4..-1]}" })
    end

    def bulk_find uuids
      uuids.split(",").map{|uuid| User.where(uuid: uuid).first}.compact
    end

    def send_push_to_all options = {}, priority = 8, delay_seconds = 0
      raise ArgumentError, "Invalid arguments：priority value in (1..16), default value is 8." unless (1..16) === priority
      raise ArgumentError, "Invalid arguments：delay_seconds value in (0..604800), default value is 0." unless (0..604800) === delay_seconds
      message = { to: :all, cid: nil }.merge!(options)
      Aliyun::Mns::Queue[ENV['PUSH_QUEUE']].send_message(message.to_json, :Priority=>priority, :DelaySeconds=>delay_seconds)
    end

    def cancel_push message_id
      while true
        messages = Aliyun::Mns::Queue[ENV['PUSH_QUEUE']].batch_receive_message(16)
        break if messages.nil?
        messages.each{|message|
          if message.id == message_id
            message.delete
            return true
          end
        }
        break if messages.length < 16
      end
      return false
    end


    def send_push_to_area province, city, options = {}, priority = 8, delay_seconds = 0
      raise ArgumentError, "Invalid arguments：priority value in (1..16), default value is 8." unless (1..16) === priority
      raise ArgumentError, "Invalid arguments：delay_seconds value in (0..604800), default value is 0." unless (0..604800) === delay_seconds
      message = { to: :area, province:province, city:city }.merge!(options)
      Aliyun::Mns::Queue[ENV['PUSH_QUEUE']].send_message(message.to_json, :Priority=>priority, :DelaySeconds=>delay_seconds)
    end

    def send_sms phone, message, priority = 8, delay_seconds = 0
      raise ArgumentError, "Invalid arguments：priority value in (1..16), default value is 8." unless (1..16) === priority
      raise ArgumentError, "Invalid arguments：delay_seconds value in (0..604800), default value is 0." unless (0..604800) === delay_seconds
      message_hash = { function: "sms", to: phone, data: message}
      Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json, :Priority=>priority, :DelaySeconds=>delay_seconds)
    end

    def send_captcha_sms phone, captcha
      message_hash = { function: "cpc_sms", to: phone, data:[captcha]}
      Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json)
    end

    def send_captcha_voice phone, captcha
      message_hash = { function: "cpc_voice", to: phone, data:[captcha]}
      Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json)
    end

    def send_template_sms to, template_code, params={}
      params['template_code'] = template_code
      message_hash = { function: "template_sms", to: to, data: params}
      Aliyun::Mns::Queue[ENV['SMS_QUEUE']].send_message(message_hash.to_json)
    end




  end
end
