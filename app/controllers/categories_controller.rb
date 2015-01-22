class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
  end

  def new
    @the_category = Category.new
  end

  def create
    @the_category = Category.new(category_params)

    if @the_category.save
      flash[:notice] = "Your category was added"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @the_category = Category.find(params[:id])
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end