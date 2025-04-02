import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  connect() {
    this.show()
  }

  show(event) {
    const show_modal = document.getElementById('show-modal');
    show_modal.classList.remove('hidden');

    document.getElementById("close_show_modal").addEventListener('click', function(event) {
      closeModal()
    })
    function closeModal() {
      show_modal.classList.add('hidden');
    }
  }
}
