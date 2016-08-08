class PagesController < ApplicationController
  
  def home
    redirect_to photos_path if logged_in?
  end
  
end
