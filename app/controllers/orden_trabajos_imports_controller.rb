class OrdenTrabajosImportsController < ApplicationController
  def new
    @orden_trabajos_import = OrdenTrabajosImport.new
  end

  def create
    @orden_trabajos_import = OrdenTrabajosImport.new(params[:orden_trabajos_import])
    if @orden_trabajos_import.save
      redirect_to listado_path
    else
      render :new
    end
  end
end
