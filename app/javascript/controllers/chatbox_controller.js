import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatbox"
export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}

