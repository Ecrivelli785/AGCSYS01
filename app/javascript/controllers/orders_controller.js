import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "row" ];

  copy() {
    fetch(`/orden_trabajos/${event.currentTarget.dataset.id}/copy`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        this.rowTarget.insertAdjacentHTML("afterend", data.tableRowPartial);
      });
  }
}
