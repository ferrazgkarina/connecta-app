class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.reviewer = current_user
    @review.reviewed = @event.user
    @review.event    = @event

    if @review.save
      redirect_to @event, notice: "Obrigada pela sua avaliação!"
    else
      redirect_to @event, alert: @review.errors.full_messages.to_sentence
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
