require('pg')

class Property

  attr_accessor :address, :value, :bedrooms, :buy_let_status
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @address = options['address']
    @value = options['value'].to_i
    @bedrooms = options['bedrooms'].to_i
    @buy_let_status = options['buy_let_status']
  end

  def save()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "INSERT INTO properties
          (address, value, bedrooms, buy_let_status)
          VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@address, @value, @bedrooms, @buy_let_status]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    @id = result[0]['id'].to_i()
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map {|options| Property.new(options)}
  end

  def delete()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "UPDATE properties SET (address, value, bedrooms, buy_let_status) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@address, @values, @bedrooms, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  # def find()
  #   db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
  #   sql = "SELECT * FROM properties WHERE id = $1"
  #   values = [@id]
  #   db.prepare("find", sql)
  #   db.exec_prepared("find")
  #   db.close()
  # end



end
