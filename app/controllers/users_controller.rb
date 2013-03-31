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
#<Response><Play>http://agile-beach-2909.herokuapp.com/ijustcalled.mp3</Play></Response>
  		:url => "http://twimlets.com/echo?Twiml=%3CResponse%3E%3CPlay%3Ehttp%3A%2F%2Fagile-beach-2909.herokuapp.com%2Fijustcalled.mp3%3C%2FPlay%3E%3C%2FResponse%3E&"
	)

	#Send explanatory text message
	@client.account.sms.messages.create(
  		:from => "+12677764203",
  		:to => @user[:recipientphone],
  		:body => "#{@user[:sendername]} just called to say I love you!"
	)

  		flash[:success] = "Sent!"
  		redirect_to root_path


  	else
  		flash[:failure] = "Not sent"
  		redirect_to root_path
  	end
  end

end
