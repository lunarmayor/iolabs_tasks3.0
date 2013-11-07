class NotesController < ApplicationController
  respond_to :js, :html
  def new
  end

  def create
  	@note = Note.new(note_params)
  	@note.author = current_user.full_name
  	@note.user_id = current_user.id
  	@note.save
  end

  def destroy
  	@note = Note.find(params[:id])
  	@note.destroy
  end

  def note_params
    params.require(:note).permit(:text, :job_id)                       
  end

end
