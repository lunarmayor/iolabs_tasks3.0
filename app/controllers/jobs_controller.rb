class JobsController < ApplicationController
  respond_to :js, :haml
  
  def index
  	@jobs = Job.all
  end

  def edit
  	@job = Job.find(params[:id])
  end

  def update
  	@job = Job.find(params[:id])
  	params[:job][:iolabs_due_date] = Job.compact_date(params[:job][:iolabs_due_date])
  	params[:job][:client_due_date] = Job.compact_date(params[:job][:client_due_date])
  	@job.update(job_params)
  	if @job.save
  		redirect_to @job
  	else
  		render :edit
  	end
  end

  def show
  	@job = Job.find(params[:id])
  	@client = Client.find(@job.client_id)
  	@users = @job.users
  	@note = Note.new
  	@notes = @job.notes.order(created_at: :desc)
  	@statuses = ["new job", "in production", "completed/to be invoiced", "invoiced"]
  end

  def new
  	@users = User.all
  	@users << User.new({last_name: "all", id: 0})
  	@clients = Client.all
  	@clients << Client.new({name: "new client"})
  	@client = Client.new
  	@job = Job.new
  end

   def update_status
    @job = Job.find(params[:id])
    @job.status = params[:job][:status]
    @job.save
    @statuses = ["new job", "in production", "completed/to be invoiced", "invoiced"]
    @users = @job.users
    @client = Client.find(@job.client_id)
  end


  def create
  	@job = Job.new(job_params)
  	@job.iolabs_due_date = @job.compact_date(:iolabs_due_date)
    @job.client_due_date = @job.compact_date(:client_due_date)
    @job.status = "new job"
    if params[:client]
      @client = Client.new(client_params)
      @client.save
      @job.client_id = @client.id
    else
      @client = Client.find(@job.client_id)
    end

    @job.save

    if params[:job][:user_id].reject(&:empty?).include?("0")
    	User.all.each do |user|
    		Jobassignment.create({user_id: user.id, job_id: @job.id})
    	end
    else
      params[:job][:user_id].reject(&:empty?).each do |id|
        Jobassignment.create({user_id: id, job_id: @job.id})
      end
    end
    if @job.save
      redirect_to @job
    else
      render :new
    end
  end

  def destroy
  	@job = Job.find(params[:id])
  	@job.destroy
  	redirect_to root_path
  end

  def job_params
    params.require(:job).permit(:user_id,
                              :client_id, 
    	                        :title, 
    	                        :description,
    	                        :status,
    	                        :iolabs_due_date,
    	                        :client_due_date)
  end


  def client_params
  	params.require(:client).permit(:name,
  		                           :address,
  		                           :logo,
  		                           :contact_name,
  		                           :phone,
  		                           :email)
  end
end
