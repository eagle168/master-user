class Coupon < ActiveRecord::Base
	include UUID
	
	self.table_name_prefix = ''
	belongs_to :users

	attr_accessor :send_range
	attr_accessor :user_phone

	validates :denomination, presence: true, length: { maximum: 999 }
	validates :end_at, presence: true
	validates :user_id, numericality: { only_integer: true }
	validates :used, inclusion: { in: [true, false] }
end