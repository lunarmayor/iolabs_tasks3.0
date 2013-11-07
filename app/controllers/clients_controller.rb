class ClientsController < ApplicationController
  def index
  	@clients = Client.all
  end

  def show
  	@client = Client.find(params[:id])
  	@active_jobs = @client.jobs.where.not(status: "invoiced")
  	@ended_jobs = @client.jobs.where(status: "invoiced")
  end

end
