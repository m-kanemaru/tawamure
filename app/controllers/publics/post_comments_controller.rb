class Publics::PostCommentsController < ApplicationController
    
    def create
        @post = Post.find(params[:post_id])
        comment = current_user.post_comments.new(post_comment_params)
        comment.post_id = @post.id
        comment.save
        @post_comment = PostComment.new
    end
    
    def destroy
        @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
        @comment.destroy
        @post_comment = PostComment.new
        @post = Post.find(params[:post_id])
    end
    
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
end
