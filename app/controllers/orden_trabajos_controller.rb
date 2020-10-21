class OrdenTrabajosController < ApplicationController

  before_action :set_orden_trabajo, only: [:show, :edit, :update, :destroy]
  before_action :listado_trabajo, only:[:digital, :offset, :post1, :post2, :post3, :post4, :post5, :post6, :post7]

  # GET /orden_trabajos
  # GET /orden_trabajos.json

  def index
    @orden_trabajos = OrdenTrabajo.all.order('clinom ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json { render json: @orden_trabajos}
             format.pdf do
        render pdf: 'listado/pdf', pdf: 'Listado'
      end
    end
  end


  def listado
    @orden_trabajos = OrdenTrabajo.all.order('clinom ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json { render json: @orden_trabajos}

      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename = Listado_ordenes_trabajo.xlsx"
      }

      format.pdf do
        render pdf: 'listado/pdf', pdf: 'Listado',
        :orientation => 'landscape'
      end
    end
  end


  def listado
    @orden_trabajos = OrdenTrabajo.all.order('clinom ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json { render json: @orden_trabajos}

      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename = Listado_ordenes_trabajo.xlsx"
      }

      format.pdf do
        render pdf: 'listado/pdf', pdf: 'Listado',
        :orientation => 'landscape'
      end

    end
  end


  # GET /orden_trabajos/1
  # GET /orden_trabajos/1.json
  def show
  end

  # GET /orden_trabajos/new
  def new
    @orden_trabajo = OrdenTrabajo.new
  end

  # GET /orden_trabajos/1/edit
  def edit
  end

  # POST /orden_trabajos
  # POST /orden_trabajos.json
  def create
    @orden_trabajo = OrdenTrabajo.new(orden_trabajo_params)

    respond_to do |format|
      if @orden_trabajo.save
        format.html { redirect_to @orden_trabajo, notice: 'Orden trabajo was successfully created.' }
        format.json { render :show, status: :created, location: @orden_trabajo }
      else
        format.html { render :new }
        format.json { render json: @orden_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orden_trabajos/1
  # PATCH/PUT /orden_trabajos/1.json
  def update
    respond_to do |format|
      if @orden_trabajo.update(orden_trabajo_params)
        format.html
        format.json { render :show, status: :ok, location: @orden_trabajo }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @orden_trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orden_trabajos/1
  # DELETE /orden_trabajos/1.json
  def destroy
    @orden_trabajo.destroy
    respond_to do |format|
      format.html
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end


# ESTE SECTOR DEL CONTROLADOR ES PARA LAS DIFERENTES VIEWS DE IMPRESIÓN Y POST
# ------------------------------------------------------------------------
def digital
end
def offset
end
def post1
end
def post2
end
def post3
end
def post4
end
def post5
end
def post6
end
def post7
end

# ------------------------------------------------------------------------

  private
    # Use callbacks to share common setup or constraints between actions.

    def listado_trabajo
      @orden_trabajos = OrdenTrabajo.all
    end

    def set_orden_trabajo
      @orden_trabajo = OrdenTrabajo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def orden_trabajo_params
      params.require(:orden_trabajo).permit(:trnum, :clinom, :nomprod,  :fecentr, :procesos, :observaciones, :estado_actual, :estado, :trcan, :gramaje, :papel, :colores, :pliego)
    end
end
