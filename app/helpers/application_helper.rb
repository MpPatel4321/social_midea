module ApplicationHelper
	FLASH_CLASSES = {
	  notice: 'alert alert-info',
	  success: 'alert alert-success',
	 }.freeze
  def flash_class(level)
  	FLASH_CLASSES[level]
  end

  def active(path)
     current_page?(path) ? 'active' : ''
  end

  def recent_conversation(friends)
  	arrange = []
  	no_chats = []
  	friends.each do |friend|
  		conversation = friend.conversation
  		if conversation.nil?
  			no_chats << friend
  		elsif conversation.messages.blank?
  			no_chats << friend
  		else
	  		message = conversation.messages.last
	  		arrange << message.id
  		end
  	end
  	arrange = arrange.sort_by { |id| -id }
  	recent_chats = []
  	arrange.each do |message_id|
  		message = Message.find(message_id)
  		recent_chats << message.conversation.friendship
  	end
  	no_chats.each do |no_chat|
  		recent_chats << no_chat	
  	end
  	recent_chats
  end

  def dynamic_search(text)
  	user = User.where(first_name: text)
  end

end
