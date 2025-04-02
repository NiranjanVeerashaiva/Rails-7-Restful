import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.show();
  }

  show() {
    this.element.classList.remove("hidden");

    setTimeout(() => {
      this.element.classList.add("hidden");
    }, 3000); 
  }
}
