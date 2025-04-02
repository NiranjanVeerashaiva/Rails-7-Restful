import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["bar", "percentage"];

  connect() {
    this.updateProgress();
  }

  updateProgress() {
    const totalTasks = parseInt(this.data.get("total"), 10) || 0;
    const completedTasks = parseInt(this.data.get("completed"), 10) || 0;
    const progress = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;

    this.barTarget.style.width = `${progress}%`; 
    this.percentageTarget.textContent = `${Math.round(progress)}% Completed`; 
  }
}
