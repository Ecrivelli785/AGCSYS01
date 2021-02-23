import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "row" ];

  copy() {
    fetch(`/orden_trabajos/${event.currentTarget.dataset.id}/copy`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        this.rowTarget.insertAdjacentHTML("afterend", data.tableRowPartial);
        $(document).ready(function() {
          $(`#orden_trabajo_procesos_${data.id}`).multiselect({
              allSelectedText: 'Showing All'
          });
        });
        $(function () {
          $(`#orden_trabajo_procesos_${data.id}`).change(function () {
            var ValorSeleccionadoDropdown = $(this).val();
            $(document).ready(function(){$(data.id).val(ValorSeleccionadoDropdown)});
          });
        });
        $('.datepicker').datepicker({format: 'mm/dd/yyyy',startDate: '-3d'});
      });
      $('.delete_ot').bind('ajax:success', function() {
  $(this).closest('tr').fadeOut();
});
  }

