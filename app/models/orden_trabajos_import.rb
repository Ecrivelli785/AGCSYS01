zclass OrdenTrabajosImport
  include ActiveModel::Model
  require 'roo'


  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_orden_trabajos
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      if row["clinom"] and row["nomprod"]

        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom like '" + row["clinom"].to_s + "' and nomprod like '" + row["nomprod"].to_s + "'").to_a

      elsif row["clinom"].nil? and row["nomprod"]
      print "row[trnum] : "
      puts row["trnum"].to_s
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom IS NUll and nomprod '" + row["nomprod"].to_s + "'").to_a

      elsif row["clinom"] and row["nomprod"].nil?
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom like '" + row["clinom"].to_s + "' and nomprod IS NULL").to_a
      elsif row["clinom"].nil? and row["nomprod"].nil?
        @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom IS NULL and nomprod IS NULL").to_a
      end


      if @orden_trabajos_bd[0] != nil
        row["id"] = (@orden_trabajos_bd[0].to_hash)["id"]
      end

      print "OT find_by_id : "
      puts OrdenTrabajo.find_by_id(row["id"])

      orden_trabajos1 =OrdenTrabajo.find_by_id(row["id"])

      if orden_trabajos1.id != nil
        orden_trabajos = OrdenTrabajo.find_by_id(row["id"])
      end

      if row["trcan"] != 0
        orden_trabajos = OrdenTrabajo.new
        orden_trabajos.attributes = row.to_hash
      end

      print "row[id] : "
      puts row["id"]

      #print "orden_trabajos.attributes :"
      #print orden_trabajos.attributes

      orden_trabajos

    end
  end

  def imported_orden_trabajos
    @imported_orden_trabajos ||= load_imported_orden_trabajos
  end

  def save

      if imported_orden_trabajos.map(&:valid?).all?
        imported_orden_trabajos.each(&:save!)
        true
      else
        imported_orden_trabajos.each_with_index do |orden_trabajos, index|
          orden_trabajos.errors.full_messages.each do |msg|
            errors.add :base, "Row #{index + 2}: #{msg}"
          end
        end
        false
      end
    end
end





class OrdenTrabajosImport
  include ActiveModel::Model
  require 'roo'
  attr_accessor :file
  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end
  def persisted?
    false
  end
  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  def load_imported_orden_trabajos
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      #AQUI SE AGREGA EL FILTRO DE TRCAN O TAMBIEN OTROS PARA EVITAR QUE SE CARGUEN
      if row["trcan"] !=0

      #AQUI CONSULTAS PARA VER SI LOS REGISTROS QUE SE VAN A IMPORTAR YA ESTAN EN LA BASE DE DATOS
        if row["clinom"] and row["nomprod"]
          @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom like '" + row["clinom"].to_s + "' and nomprod like '" + row["nomprod"].to_s + "'").to_a
        elsif row["clinom"].nil? and row["nomprod"]
          #print "row[trnum] : "
          #puts row["trnum"].to_s
          @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom IS NUll and nomprod '" + row["nomprod"].to_s + "'").to_a
        elsif row["clinom"] and row["nomprod"].nil?
          @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom like '" + row["clinom"].to_s + "' and nomprod IS NULL").to_a
        elsif row["clinom"].nil? and row["nomprod"].nil?
          @orden_trabajos_bd = OrdenTrabajo.connection.select_all("SELECT id FROM orden_trabajos WHERE trnum = " + row["trnum"].to_s + " and clinom IS NULL and nomprod IS NULL").to_a
        end

        #UNA VEZ QUE SE TERMINAN LAS CONSULTAS, SE CARGA EL "id" QUE ESTE EN REALIDAD ES EL id DE LA BASE DE DATOS, NO ES EL NRO DE ORDEN DE COMPRA (ot)
        if @orden_trabajos_bd[0] != nil
          row["id"] = (@orden_trabajos_bd[0].to_hash)["id"]
        end

        #AQUI CONSULTAS SI row["id"] NO ES NIL, EN LA PRIMERA CARGA NO HAY DATOS EN LA BD Y EL id ES nil, PERO EN LAS CARGAS POSTERIORES LOS REGISTROS QUE SE VAN A CARGAR YA ESTAN EN LA BD
        if row["id"] != nil
          @orden_trabajos = OrdenTrabajo.find_by_id(row["id"])
          print "****----*****+++ row[id] : \r\n"
          print row["id"]
        else
          @orden_trabajos = OrdenTrabajo.new
        end
        @orden_trabajos.attributes = row.to_hash

        #print " \r\n"
        print "****----*****+++ orden_trabajos.attributes : \r\n"
        print @orden_trabajos.attributes
      end
      @orden_trabajos
    end
  end
  def imported_orden_trabajos
    if load_imported_orden_trabajos
      @imported_orden_trabajos ||= load_imported_orden_trabajos
    end
  end
  def save
      if imported_orden_trabajos.map(&:valid?).all?
        imported_orden_trabajos.each(&:save!)
        true
      else
        imported_orden_trabajos.each_with_index do |orden_trabajos, index|
          orden_trabajos.errors.full_messages.each do |msg|
            errors.add :base, "Row #{index + 2}: #{msg}"
          end
        end
        false
      end
  end
end
