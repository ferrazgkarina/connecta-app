class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    if user_signed_in?
      city = current_user.profile&.location
      attended = current_user.attended_events
      created  = current_user.events
      all_confirmed = (attended + created).uniq

      @next_events   = all_confirmed.select { |e| e.date >= Date.today }.sort_by(&:date).first(3)
      @new_city_events = Event.where(city: city)
                              .where.not(user: current_user)
                              .where("created_at >= ?", 7.days.ago)
                              .order(created_at: :desc)
                              .limit(3)
    end
  end

  def about
  end
end
