import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["messages", "input"]
  static values  = { eventId: Number, currentUsername: String }

  connect() {
    // Evita inscrições duplicadas (Turbo cache)
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
    this.subscription = consumer.subscriptions.create(
      { channel: "ChatChannel", event_id: this.eventIdValue },
      { received: (data) => this.appendMessage(data) }
    )
    this.scrollToBottom()
  }

  disconnect() {
    this.subscription?.unsubscribe()
    this.subscription = null
  }

  send(event) {
    event.preventDefault()
    const content = this.inputTarget.value.trim()
    if (!content) return

    fetch(this.element.dataset.url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ content })
    })
    this.inputTarget.value = ""
  }

  appendMessage(data) {
    const isOwn = data.username === this.currentUsernameValue
    const div = document.createElement("div")
    div.className = `d-flex mb-2 ${isOwn ? "justify-content-end" : "justify-content-start"}`
    div.innerHTML = `
      <div style="max-width:75%">
        ${!isOwn ? `<p class="text-muted mb-1" style="font-size:0.7rem">@${data.username}</p>` : ""}
        <div class="rounded-3 px-3 py-2 ${isOwn ? "bg-dark text-white" : "bg-light"}">
          <p class="mb-0 small">${data.content}</p>
        </div>
        <p class="text-muted mt-1 ${isOwn ? "text-end" : ""}" style="font-size:0.65rem">${data.time}</p>
      </div>
    `
    this.messagesTarget.appendChild(div)
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }
}
