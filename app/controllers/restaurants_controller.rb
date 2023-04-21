class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.search(params[:query])
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
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
#    Restaurant.increment_counter(:upvote, params[:id])
    redirect_to action: "index" 
  end

  def increaseDownvote
    @thisRestaurant = Restaurant.find(params[:id])
    @thisUser = current_user
    Review.create(restaurant: @thisRestaurant, user: @thisUser, upvote: 0, downvote: 1)
#    Restaurant.increment_counter(:downvote, params[:id])
    redirect_to action: "index" 
  end
  
  def showUpvote(id)
    @restaurantVotes = Review.where("restaurant_id == ?", id)
    tally = 0
    @restaurantVotes.each do |vote|
      tally = vote.upvote + tally
    end
    tally
  end
  
  def showDownvote(id)
    @restaurantVotes = Review.where("restaurant_id == ?", id)
    tally = 0
    @restaurantVotes.each do |vote|
      tally = vote.downvote + tally
    end
    tally
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
