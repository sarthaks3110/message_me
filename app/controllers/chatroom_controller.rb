class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    @messages = Message.includes(:user).order(created_at: :asc)
  end
end
