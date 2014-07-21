class MessageTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, message)
    insert_message_sql = <<-SQL
      INSERT INTO message (name, message)
      VALUES ('#{name}','#{message}')
      RETURNING id
    SQL

    @database_connection.sql(insert_message_sql).first["id"]
  end

  def find_by(name, message)
    find_by_sql = <<-SQL
      SELECT * FROM message
      WHERE name = '#{name}'
      AND message = '#{message}'
    SQL

    @database_connection.sql(find_by_sql).first
  end

end#class end