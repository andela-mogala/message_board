class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_message, only: [:show, :edit, :update, :destroy]
  def index
    @messages = Message.all.order("created_at DESC").limit(10)
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_url
    else 
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @message.update_attributes(message_params)
      redirect_to message_path
    else 
      render 'edit'
    end
  end

  def destroy
    if @message.destroy
      redirect_to root_url
    end
  end

  private
  def message_params
    params.require(:message).permit(:title, :description)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end
