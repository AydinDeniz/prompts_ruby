
class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @online_users = User.where(online: true)
  end
end
