import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "username"]

  search() {
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      this.resultsTarget.classList.add("d-none")
      return
    }

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      fetch(`/users/search?q=${encodeURIComponent(query)}`)
        .then(r => r.json())
        .then(users => this.showResults(users))
    }, 300)
  }

  showResults(users) {
    if (users.length === 0) {
      this.resultsTarget.innerHTML = `<p class="text-muted small p-2 mb-0">Nenhuma usuária encontrada.</p>`
      this.resultsTarget.classList.remove("d-none")
      return
    }

    this.resultsTarget.classList.remove("d-none")
    this.resultsTarget.innerHTML = users.map(u => `
      <div class="d-flex align-items-center gap-2 p-2 result-item" style="cursor:pointer" data-username="${u.username}" data-name="${u.name || u.username}">
        <div class="rounded-circle bg-secondary flex-shrink-0" style="width:32px;height:32px"></div>
        <div>
          <p class="small fw-bold mb-0">${u.name || u.username}</p>
          <p class="text-muted mb-0" style="font-size:0.75rem">@${u.username}</p>
        </div>
      </div>
    `).join('<hr class="my-0">')

    this.resultsTarget.querySelectorAll(".result-item").forEach(item => {
      item.addEventListener("click", () => {
        this.usernameTarget.value = item.dataset.username
        this.inputTarget.value = `${item.dataset.name} (@${item.dataset.username})`
        this.resultsTarget.innerHTML = ""
        this.resultsTarget.classList.add("d-none")
      })
    })
  }
}
