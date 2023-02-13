class CommentsController < ApplicationController
    def create
        @video = Video.find(params[:video_id])
        @comment = @video.comments.create(params[:comment].permit(:content, :parent_id).merge(video_id: params[:video_id]))
        redirect_to request.referer, notice: "Comment success."
    end
    def destroy
        @video = Video.find(params[:video_id])
        @comment = @video.comments.find(params[:id])
        @comment.destroy
        redirect_to request.referer, notice: "Delete comment success."
    end
end
