class PhotosController < ApplicationController
  
  before_action :set_photo, only: [:edit, :update, :show, :like, :already_commented?]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @photos = Photo.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comments = Comment.where(:photo_id => params[:id]).paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @photo  = Photo.new
  end
  
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
      
    if @photo.save
      flash[:success] = "Your photo was uploaded successfully!"
      redirect_to photos_path
    else
      render 'new'
    end
  end
  
  def edit

  end
  
  def update

    if @photo.update(photo_params)
      flash[:success] = "Successfully edited " + @photo.title + "!"
      redirect_to photo_path(@photo)
    else
      render 'new'
    end
  end
  
  def like
    like = Like.create(like: params[:like], user: current_user, photo: @photo)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a photo once"
      redirect_to :back
    end
  end
  
  def destroy
    Photo.find(params[:id]).destroy
    flash[:success] = "Photo Deleted"
    redirect_to photos_path
  end

  private
    def photo_params
      params.require(:photo).permit(:title, :description, :picture, :remove_picture, tag_ids: [])
    end
  
    def set_photo
      @photo = Photo.find(params[:id])
    end
    
    def require_same_user
      if current_user != @photo.user and !current_user.admin?
        flash[:danger] = "You can only edit your own photos"
        redirect_to photos_path
      end
    end
    
    def admin_user
      redirect_to photos_path unless current_user.admin?
    end
  
end