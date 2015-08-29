class MediaFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_file, only: [:show, :edit, :update, :destroy, :share_media_file]

  def index
    @media_files = current_user.all_files
  end

  def show
    redirect_to media_files_path unless @media_file
  end

  def new
    @media_file = current_user.media_files.new
  end

  def edit
  end

  def create
    if media_file_params[:link_url].present?
      media_file_params.delete :uploaded_file
    end
    @media_file = current_user.media_files.new(media_file_params)

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to @media_file, notice: 'Asset was successfully created.' }
        format.json { render :show, status: :created, location: @media_file }
      else
        format.html { render :new }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @media_file.update(media_file_params)
        format.html { redirect_to @media_file, notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_file }
      else
        format.html { render :edit }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @media_file.destroy
    respond_to do |format|
      format.html { redirect_to media_files_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share_media_file
    if @media_file.user == current_user && EmailValidator.valid?(params[:email])
      user_shared = User.find_by(email: params[:email]) || User.invite!(:email => params[:email])
      SharedMediaFile.create(user: user_shared, media_file: @media_file)
      @response = "File was shared with #{user_shared.email}"
    else
      @response = "File can't be shared."
    end
  end

  private
    def set_media_file
      @media_file = MediaFile.find_by(user_id: current_user.id, id: params[:id]) || SharedMediaFile.find_by(user_id: current_user.id, media_file_id: params[:id]).try(:media_file)
    end

    def media_file_params
      params.require(:media_file).permit(:user_id, :uploaded_file, :link_url)
    end
end
