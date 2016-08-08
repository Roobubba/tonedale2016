class CommentsController < ApplicationController
  
  before_action :set_photo
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @comments = Comment.where(:photo_id => params[:photo_id]).paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.photo = @photo
    
    if @comment.save
      flash[:success] = "Your comment was posted successfully!"
      redirect_to photo_path(@photo)
    else
      render 'new'
    end
  end
  
  def edit

  end
  
  def update
    if @comment.update(comment_params)
      flash[:success] = "Successfully edited the comment"
      redirect_to photo_path(@photo)
    else
      render 'new'
    end
  end
  
  def show
    @comment= Comment.find_by(photo_id: @photo.id)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment Deleted"
    redirect_to photo_path(id: @photo.id)
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    def set_photo
      @photo = Photo.find(params[:photo_id])
    end
  
    def require_same_user
      @comment = Comment.find(params[:id])
      if current_user != @comment.user and !current_user.admin?
        flash[:danger] = "You can only edit your own comments"
        redirect_to photo_path(@photo)
      end
    end
    
    def admin_user
      redirect_to photos_path unless current_user.admin?
    end
end