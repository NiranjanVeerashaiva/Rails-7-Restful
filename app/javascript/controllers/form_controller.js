import { Controller } from "@hotwired/stimulus";
export default class extends Controller {

  static targets = ["title", "description", "titleError", "descError"]

  connect() {
    this.comment()
  }

  comment(event) {
    const comment_modal = document.getElementById('popup-modal');
    comment_modal.classList.remove('hidden');

    document.getElementById("close_modal").addEventListener('click', function(event) {
      closeModal()
    })
    function closeModal() {
      comment_modal.classList.add('hidden');
    }
  }

  validateForm(event){
    let isValid = true;

    if(this.titleTarget.value.trim() === ""){
      isValid = false;
      this.titleErrorTarget.classList.remove("hidden")
    } else {
      this.titleErrorTarget.classList.add("hidden")
    }

    if(this.descriptionTarget.value.trim() === ""){
      isValid = false;
      this.descErrorTarget.classList.remove("hidden")
    } else {
      this.descErrorTarget.classList.add("hidden")
    }

    if(!isValid){
      event.preventDefault()
    }
  }

  hideModal(event) {
    if (event.detail.success) {
      const comment_modal = document.getElementById("popup-modal");
      comment_modal.classList.add("hidden");
    }
  }
}