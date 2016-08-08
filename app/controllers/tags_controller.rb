class TagsController < ApplicationController
  
  before_action :require_user, except: [:show]
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = @tag.name + " tag was added successfully!"
      redirect_to photos_path
    else
      render 'new'
    end  
  end
  
  def show
    @tag = Tag.find(params[:id])  
    @photos = @tag.photos.paginate(page: params[:page], per_page: 5)
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end