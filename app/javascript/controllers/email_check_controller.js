import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "feedback"]

  connect() {
    this.timeout = null
  }

  check() {
    clearTimeout(this.timeout)
    const email = this.inputTarget.value.trim()

    if (!email || !email.includes("@")) {
      this.clearFeedback()
      return
    }

    this.timeout = setTimeout(() => {
      fetch(`/users/check_email?email=${encodeURIComponent(email)}`, {
        headers: { "Accept": "application/json" }
      })
        .then(r => r.json())
        .then(data => {
          if (data.taken) {
            this.inputTarget.classList.add("is-invalid")
            this.inputTarget.classList.remove("is-valid")
            this.feedbackTarget.textContent = "Esse email já está em uso. Já tem uma conta aqui?"
            this.feedbackTarget.className = "invalid-feedback d-block"
          } else {
            this.inputTarget.classList.add("is-valid")
            this.inputTarget.classList.remove("is-invalid")
            this.feedbackTarget.textContent = ""
            this.feedbackTarget.className = ""
          }
        })
        .catch(() => this.clearFeedback())
    }, 400)
  }

  clearFeedback() {
    this.inputTarget.classList.remove("is-invalid", "is-valid")
    this.feedbackTarget.textContent = ""
    this.feedbackTarget.className = ""
  }
}
