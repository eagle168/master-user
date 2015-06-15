module PushMessageHelper
	def self.notify_show_news_options type, uuid, url, title, message
  		base_options "show_news", type, uuid, url, title, message
  	end

        def self.notify_show_match_options uuid, title, message
                base_options "show_match", nil, uuid, nil, title, message
        end

        def self.notify_show_weburl_options url, title, message
                base_options "show_weburl", nil, nil, url, title, message
        end

        def self.notify_show_booking_options uuid, title, message
                base_options "show_booking", nil, uuid, nil, title, message
        end

        def self.notify_show_forum_options uuid, title, message
                base_options "show_forum", nil, uuid, nil, title, message
        end

        def self.notify_show_beautie_options uuid, title, message
                base_options "show_beautie", nil, uuid, nil, title, message
        end

        def self.notify_show_vote_options type, title, message
                base_options "show_vote", type, nil, nil, title, message
        end

  	private
	def self.base_options action_name, type, uuid, url, title, message
    		{
      		action: action_name,
        		params: {
        			type: type,
        			uuid: uuid,
        			url: url,
        		},
        		content: {
          			title: title,
          			message: message,
        		},
    		}
  	end
end