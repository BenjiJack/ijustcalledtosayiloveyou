class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save

  		flash[:success] = "Sent!"
  		redirect_to root_path


  	else
  		flash[:failure] = "Not sent"
  		redirect_to root_path
  	end
  end

end
