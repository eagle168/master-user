# -*- encoding : utf-8 -*-
class TradeRecord < ActiveRecord::Base
  include UUID
  self.table_name_prefix = ''
  
  belongs_to :user
end
