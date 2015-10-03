class CouponClass < ActiveRecord::Base
	include UUID
	
	self.table_name_prefix = 'shop_'
end