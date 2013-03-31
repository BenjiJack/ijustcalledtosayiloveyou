class UsersController < ApplicationController

require 'twilio-ruby'




  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save

  	#Instantiate Twilio client
	account_sid = 'AC31e65c7b5abd8ea30ade9abbbd169abf'
	auth_token = 'ab3f73cd65470a3fc1ae817d74a56bbd'
	@client = Twilio::REST::Client.new account_sid, auth_token

	#Make phone call and play sound file
	@call = @client.account.calls.create(
  		:from => "+12677764203",
  		:to => @user[:recipientphone],
  		# returns XML using twimlets - see https://www.twilio.com/labs/twimlets/echo
  		#<Response>
		#<Say voice="woman">Hi X, Y has a message for you!</Say>
		#<Play>http://agile-beach-2909.herokuapp.com/ijustcalled.mp3</Play>
		#<Say voice="woman">I just called to say I love you dot com</Say>
		#</Response>
  		:url => "http://twimlets.com/echo?Twiml=%3CResponse%3E%0A%3CSay%20voice%3D%22woman%22%3EHi%20" + @user[:recipientname].split.join("%20") + "%2C%20" + @user[:sendername].split.join("%20") + "%20has%20a%20message%20for%20you!%3C%2FSay%3E%0A%3CPlay%3Ehttp%3A%2F%2Fagile-beach-2909.herokuapp.com%2Fijustcalled.mp3%3C%2FPlay%3E%0A%3CSay%20voice%3D%22woman%22%3EI%20just%20called%20to%20say%20I%20love%20you%20dot%20com%3C%2FSay%3E%0A%3C%2FResponse%3E&"
	)

	#Send explanatory text message
	@client.account.sms.messages.create(
  		:from => "+12677764203",
  		:to => @user[:recipientphone],
  		:body => "#{@user[:sendername]} just called to say I love you! www.ijustcalledtosayiloveyou.com"
	)

  		flash[:success] = "Sent!"
  		redirect_to root_path


  	else
  		flash[:failure] = "Complete all fields. Use <25 char and valid phone #"
  		redirect_to root_path
  	end
  end

end
