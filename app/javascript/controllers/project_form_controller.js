import { Controller } from "@hotwired/stimulus";
export default class extends Controller {


  connect() {
    this.project()
  }

  project(event) {
    const comment_modal = document.getElementById('project-popup');
    comment_modal.classList.remove('hidden');

    document.getElementById("close_modal").addEventListener('click', function(event) {
      closeModal()
    })
    function closeModal() {
      comment_modal.classList.add('hidden');
    }
  }
}