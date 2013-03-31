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
  		:to => "+1#{@user[:recipientphone]}",

  		:url => "http://agile-beach-2909.herokuapp.com/soundplay.html"
	)

	#Send explanatory text message
	@client.account.sms.messages.create(
  		:from => "+12677764203",
  		:to => "+1#{@user[:recipientphone]}",
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
