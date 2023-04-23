class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
  end

  def show;end

  def new
    @room = Room.new
  end

  def edit;end

  def create
    @room = Room.new(room_params)
    return redirect_to @room if @room.save

    render :index
  end

  def update
    return redirect_to @room if @room.update(room_params)

    render :edit
  end

  def destroy
    return redirect_to @room if @room.destroy

    render :index
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def fetch_room
    @room = Room.find(params[:id])
  end
end
