class CityInterestsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @city_interest = CityInterest.new
  end

  def create
    @city_interest = CityInterest.new(city_interest_params)
    if @city_interest.save
      redirect_to new_city_interest_path, notice: "registered"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def city_interest_params
    params.require(:city_interest).permit(:email, :city)
  end
end
