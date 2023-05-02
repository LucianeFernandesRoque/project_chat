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

    respond_to do |format|
      if @room.save
        UserRoom.create(room: @room, user: current_user)
        format.turbo_stream { render turbo_stream: turbo_stream.append('rooms', partial: 'shared/room', locals: {room: @room }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('room_form', partial: 'rooms/form', locals: { room: @room }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'shared/room', locals: {room: @room }) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    return redirect_to @room if @room.destroy

    render :index
  end

  def add_user
    UserRoom.create(room: params[:room_id], user: params[:user_id])

    respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("room_#{params[:room_id]}", partial: 'rooms/room', locals: {room: Room.find(parans[room_id]) }) }
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def fetch_room
    @room = Room.find(params[:id] || params[:room_id])
  end
end
