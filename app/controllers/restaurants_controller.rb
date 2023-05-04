class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.search(params[:query])
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    @comments = Comment.where("restaurant_id == ?", @restaurant)
    @fave = Favorite.where("user_id == ? AND restaurant_id == ?", current_user, @restaurant)
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def increaseUpvote
    @thisRestaurant = Restaurant.find(params[:id])
    @thisUser = current_user
    Review.create(restaurant: @thisRestaurant, user: @thisUser, upvote: 1, downvote: 0)
    redirect_to action: "index" 
  end

  def increaseDownvote
    @thisRestaurant = Restaurant.find(params[:id])
    @thisUser = current_user
    Review.create(restaurant: @thisRestaurant, user: @thisUser, upvote: 0, downvote: 1)
    redirect_to action: "index" 
  end
  
  def summary
    @comments = Comment.where("user_id == ?", current_user)
    @votes = Review.where("user_id == ?", current_user)
    @favorites = Favorite.where("user_id == ?", current_user)
  end
  
  def newComment
    @restaurant = Restaurant.find(params[:restaurant])
  end
  
  def addComment
    @thisRestaurant = Restaurant.find(params[:restaurant])
    @thisUser = current_user
    Comment.create(restaurant: @thisRestaurant, user: @thisUser, fullComment: params[:fullComment])
    respond_to do |format|
      format.html { redirect_to restaurant_url(@thisRestaurant), notice: "Comment successfully added." }
      format.json { head :no_content }
    end
  end
  
  def toggleFavorite
    @thisRestaurant = Restaurant.find(params[:restaurant])
    @thisUser = current_user
    begin
      Favorite.create(restaurant: @thisRestaurant, user: @thisUser, isFavorite: true)
    rescue ActiveRecord::RecordNotUnique => e
      @oldFavorite = Favorite.where("user_id == ? AND restaurant_id == ?", @thisUser, @thisRestaurant)
      @oldFavorite.each do |favorite|
        favorite.toggle!(:isFavorite)
      end
    end
    respond_to do |format|
      format.html { redirect_to restaurant_url(@thisRestaurant), notice: "Favorite changed." }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :location, :upvote, :downvote, :query)
    end
end
