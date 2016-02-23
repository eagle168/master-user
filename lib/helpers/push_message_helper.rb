module PushMessageHelper
        #新闻祥请
	def self.notify_show_news_options type, uuid, url, title, message
  		base_options "show_news", type, nil, uuid, url, title, message
  	end
        #赛事详情
        def self.notify_show_match_options uuid, title, message
                base_options "show_match", nil, nil, uuid, nil, title, message
        end
        #网页（活动、URL）
        def self.notify_show_weburl_options url, title, message
                base_options "show_weburl", nil, nil, nil, url, title, message
        end
        #球场订场
        def self.notify_show_booking_options uuid, title, message
                base_options "show_booking", nil, nil, uuid, nil, title, message
        end
        #论坛详情
        def self.notify_show_forum_options uuid, title, message
                base_options "show_forum", nil, nil, uuid, nil, title, message
        end
        #美女详情
        def self.notify_show_beautie_options uuid, title, message
                base_options "show_beautie", nil, nil, uuid, nil, title, message
        end
        #分类球场投票列表
        def self.notify_show_vote_options type, title, message
                base_options "show_vote", type, nil, nil, nil, title, message
        end
        #商城优惠券列表
        def self.notify_shop_coupons_options title, message
               base_options "show_coupons", "shop", nil, nil, nil, title, message
        end
        #订场优惠券列表
        def self.notify_booking_coupons_options title, message
               base_options "show_coupons", "booking", nil, nil, nil, title, message
        end
        #商城某种类（或子种类）商品列表
        def self.notify_shop_products_by_classes_options page_title, uuid, title, message
               base_options "shop_products_by_classes", nil, page_title, uuid, nil, title, message
        end
        #商城商品详情
        def self.notify_shop_product_options uuid, title, message
               base_options "shop_product", nil, nil, uuid, nil, title, message
        end
        #特殊商品列表（包括推荐商品等）
        def self.notify_shop_products_by_palac_options page_title, uuid, title, message
               base_options "shop_products_by_place", nil, page_title, uuid, nil, title, message
        end
        #某品牌的商品列表
        def self.notify_shop_products_by_brand_options page_title, uuid, title, message
               base_options "shop_products_by_brand", nil, page_title, uuid, nil, title, message
        end
        #商城首页
        def self.notify_shop_index_options title, message
               base_options "shop_index", nil, nil, nil, nil, title, message
        end

  	private
        # action_name 动作名
        # type  类型名
        # page_title  打开页面的标题
        # uuid 
        # url
        # title  提示框的标题
        # message  提示框的描述信息
	def self.base_options action_name, type, page_title, uuid, url, title, message
    		{
      		action: action_name,
        		params: {
        			type: type,
        			uuid: uuid,
        			url: url,
                                page_title: page_title
        		},
        		content: {
          			title: title,
          			message: message,
        		},
    		}
  	end
end