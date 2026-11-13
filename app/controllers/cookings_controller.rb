class CookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cooking, only: %i[show edit update destroy]
  before_action :authorize_cooking!, only: %i[edit update destroy]

  def index
    @cookings = Cooking.includes(:genre, :user).all

    if params[:title].present?
      @cookings = @cookings.where(
        "cookings.title LIKE ?",
        "%#{Cooking.sanitize_sql_like(params[:title])}%"
      )
    end

    if params[:genre_id].present?
      @cookings = @cookings.where(genre_id: params[:genre_id])
    end
  end

  def show
  end

  def new
    @cooking = current_user.cookings.build
  end

  def create
    @cooking = current_user.cookings.build(cooking_params)

    if @cooking.save
      redirect_to @cooking, notice: "Cooking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @cooking.update(cooking_params)
      redirect_to @cooking, notice: "Cooking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cooking.destroy
    redirect_to cookings_path, notice: "Cooking was successfully deleted.",
              status: :see_other
  end

  private

  def set_cooking
    @cooking = Cooking.find(params[:id])
  end

  def authorize_cooking!
    head :forbidden unless @cooking.user == current_user
  end

  def cooking_params
    params.require(:cooking).permit(:title, :content, :genre_id)
  end
end