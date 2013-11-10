class ClientsController < ApplicationController
  def index
  	@clients = Client.all
  end

  def edit
  	@client = Client.find(params[:id])
  end

  def update
  	@client = Client.find(params[:id])
  	@client.update(client_params)
    if @client.save
      redirect_to @client
    else
      render :edit
    end
  end

  def show
  	@client = Client.find(params[:id])
  	@active_jobs = @client.jobs.where.not(status: "invoiced")
  	@ended_jobs = @client.jobs.where(status: "invoiced")
  end

  def destroy
  	@client = Client.find(params[:id])
  	@client.destroy
  	redirect_to root_path
  end


 
  def client_params
    params.require(:client).permit(:name,
                              :address, 
    	                        :contact_name, 
    	                        :phone,
    	                        :email,
    	                        :logo)
  end

end
