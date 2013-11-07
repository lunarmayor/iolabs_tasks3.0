class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!, only: [:show, :index]
  before_filter :set_me
  def index
  	@users = User.all
  end

  def show 
  	if params[:id]
  	  @user = User.find(params[:id])
  	else
  	  @user = current_user
  	end

    @jobs = @user.jobs.where.not(status: ["invoiced", "new job"]).order(:iolabs_due_date)

  end
  
  def set_me
    @me = current_user
  end
end
