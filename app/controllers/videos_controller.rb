class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ show index ]
  before_action :correct_user, only: %i[ edit update destroy ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all.order(cached_votes_score: :desc)
  end

  def upvote
    @video = Video.find(params[:id])
    if current_user.voted_up_on? @video
      @video.unvote_by current_user
      redirect_to request.referer, notice: "You dislike this video."
    else
      @video.upvote_by current_user
      redirect_to request.referer, notice: "You like this video."
    end
    # render "vote.js.erb"
    # redirect_to request.referer, notice: "You like this video."
  end
  
  def downvote
    @video = Video.find(params[:id])
    if current_user.voted_down_on? @video
      @video.unvote_by current_user
      redirect_to request.referer
    else
      @video.downvote_by current_user
      redirect_to request.referer, notice: "You dislike this video."
    end
    # render "vote.js.erb"
  end

  # GET /videos/1 or /videos/1.json
  def show
    @videos = Video.all.order(cached_votes_score: :desc)
  end

  # GET /videos/new
  def new
    @video = current_user.videos.build
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
  def create
    @video = current_user.videos.build(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to video_url(@video), notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to video_url(@video), notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :body, :user_id, :file)
    end

    def correct_user
      @video = current_user.videos.find_by_id(params[:id])
      redirect_to videos_path notice: "Only the creator can access this page!" if @video.nil?
    end
end
