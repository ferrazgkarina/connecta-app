class UsersController < ApplicationController
  def search
    query = params[:q].to_s.strip
    if query.length >= 2
      profiles = Profile.where("name ILIKE ? OR username ILIKE ?", "%#{query}%", "%#{query}%")
                        .where.not(user_id: current_user.id)
                        .limit(5)
      render json: profiles.map { |p| { name: p.name, username: p.username } }
    else
      render json: []
    end
  end
end
