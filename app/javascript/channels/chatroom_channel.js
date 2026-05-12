import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const messagesContainer = document.getElementById("messages")
  if (!messagesContainer) return
  const onlineUsersList = document.getElementById("online-users-list")

  const subscription = consumer.subscriptions.create("ChatroomChannel", {
    received(data) {
      if (onlineUsersList && Array.isArray(data.online_users)) {
        onlineUsersList.innerHTML = ""
        if (data.online_users.length === 0) {
          onlineUsersList.insertAdjacentHTML("beforeend", `<div class="item">No one online</div>`)
        } else {
          data.online_users.forEach((username) => {
            onlineUsersList.insertAdjacentHTML("beforeend", `<div class="item">${username}</div>`)
          })
        }
      }

      const feed = messagesContainer.querySelector(".ui.feed")
      if (!feed) return
      if (data.message_html) {
        feed.insertAdjacentHTML("beforeend", data.message_html)
        messagesContainer.scrollTop = messagesContainer.scrollHeight
      }
    }
  })

  // Auto-scroll on initial load
  messagesContainer.scrollTop = messagesContainer.scrollHeight

  // Optional: clean up when leaving page
  document.addEventListener("turbo:before-render", () => {
    if (subscription) {
      consumer.subscriptions.remove(subscription)
    }
  })
})

