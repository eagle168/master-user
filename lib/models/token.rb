# -*- encoding : utf-8 -*-
class Token < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :user

  before_create :set_content_and_expired_at
  after_create :first_create_send_coupon

  scope :generate, -> { self.create }
  scope :available, -> { where(available: true).where('expired_at >= ?', Time.now).order(created_at: :desc).limit(1).first }

  def expire!
    self.update({ available: false })
  end

  protected
  def set_content_and_expired_at
    self.content = Digest::MD5.hexdigest("#{self.user.phone}-#{Time.now}-#{rand}")
    self.expired_at = Time.now + 1.year
  end

  def first_create_send_coupon
        if self.user.tokens.count==1
              coupon_class = CouponClass.where("name = '注册后系统送券'").where("beginning_on <= ? ", Date.current.strftime("%Y-%m-%d")).where("end_on >= ?", Date.current.strftime("%Y-%m-%d") ).first
              if coupon_class.present?
                      date = (Date.current + coupon_class.days.days).to_date if Date.current >= coupon_class.beginning_on
                      CouponItem.create({user_id: user.id, coupon_class_id: coupon_class.id,
                                         expired_on: [date, coupon_class.end_on].min})
                       # 如果该用户可以推送，则推送信息（有 cid 信息）
                      self.user.send_push(PushMessageHelper::notify_shop_coupons_options("账户信息提示", "您收到一张佰佳商城优惠券。")) if self.user.cid.present?
              end
              coupon_class_names = ['壹佰满299送20元', '壹佰满499送50元', '壹佰满990送100元']
              send_count = 0
              coupon_class_names.each do | name |
                      coupon_class = CouponClass.where("name = ?", name).where("end_on >= ?", Date.current.strftime("%Y-%m-%d") ).first
                      if coupon_class.present?
                              date = (coupon_class.beginning_on + coupon_class.days.days).to_date  if Date.current < coupon_class.beginning_on
                              date = (Date.current + coupon_class.days.days).to_date if Date.current >= coupon_class.beginning_on
                              CouponItem.create({user_id: user.id, coupon_class_id: coupon_class.id,
                                                 expired_on: [date, coupon_class.end_on].min})
                              send_count += 1
                      end
             end 
             # 如果该用户可以推送，则推送信息（有 cid 信息）
              self.user.send_push(PushMessageHelper::notify_shop_coupons_options("账户信息提示", "您收到 #{send_count} 张佰佳商城优惠券。")) if send_count>0 and self.user.cid.present?
        end
  end
end
