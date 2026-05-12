class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel"
    add_current_user_to_online
    transmit_online_users
    broadcast_online_users
  end

  def unsubscribed
    remove_current_user_from_online
    broadcast_online_users
  end

  private

  ONLINE_USERS_KEY = "chatroom:online_users"

  def add_current_user_to_online
    return unless current_user

    Rails.cache.write(
      ONLINE_USERS_KEY,
      (online_user_ids + [current_user.id]).uniq,
      expires_in: 12.hours
    )
  end

  def remove_current_user_from_online
    return unless current_user

    Rails.cache.write(
      ONLINE_USERS_KEY,
      (online_user_ids - [current_user.id]),
      expires_in: 12.hours
    )
  end

  def online_user_ids
    Rails.cache.read(ONLINE_USERS_KEY) || []
  end

  def broadcast_online_users
    users = User.where(id: online_user_ids).order(:username).pluck(:username)

    ActionCable.server.broadcast("chatroom_channel", {
      online_users: users
    })
  end

  def transmit_online_users
    users = User.where(id: online_user_ids).order(:username).pluck(:username)
    transmit({ online_users: users })
  end
end

