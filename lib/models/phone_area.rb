class PhoneArea < ActiveRecord::Base
	self.table_name_prefix = ''
	belongs_to :user

	def update_phone_areas 
		
	end

# 	require 'open-uri'
# require 'nokogiri'
# require 'igetui'
# require 'uri'
                
                
#         def self.sms options
#                 begin
#                         url = URI.encode("http://121.199.16.178/webservice/sms.php?method=Submit&account=cf_twyd&password=teewell-2014&mobile=#{options["phone"]}&content=#{options["content"]}")
#                         dom = Nokogiri::HTML(open(url))
#                         result = dom.at_xpath('//code').content
#                         #result code  返回码，可查看互亿无线帮助文档中的验证码平台后台报错类型大全
#                         codes = %w(2 4010 403 4030 404 406 407 4072 4073 408 4080 4081 4082 4083 4084 4085 4086)
#                         codes.include?result  
#                 rescue Exception => ex
#                         p "\n\t[#{__method__.to_s()}]\n\t#{ex.message}\n\t#{options.to_s}"
#                         return false 
#                 end
#         end
end