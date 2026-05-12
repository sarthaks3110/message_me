import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-form"
export default class extends Controller {
  static targets = ["input"]

  afterSubmit(event) {
    if (event.detail.success) {
      this.inputTarget.value = ""
      this.inputTarget.focus()
    }
  }
}

