class CommentsController < ApplicationController
    before_action :find_video, only: %i[ create destroy ]
    def create
        @comment = @video.comments.new(comment_params)
        if @comment.save
            redirect_to request.referer, notice: "Comment success."
        else
            redirect_to request.referer, notice: "Comment failed."
        end
    end
    def destroy
        @comment = @video.comments.find(params[:id])
        @comment.destroy
        redirect_to request.referer, notice: "Delete comment success."
    end
    private
    def comment_params
        params[:comment]
        .permit(:content, :parent_id, :user_id)
        .merge(video_id: params[:video_id])
    end
    def find_video
        @video = Video.find(params[:video_id])
    end
end
