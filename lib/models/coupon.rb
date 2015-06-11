class Coupon < ActiveRecord::Base
	include UUID
	
	self.table_name_prefix = ''
	belongs_to :users

end