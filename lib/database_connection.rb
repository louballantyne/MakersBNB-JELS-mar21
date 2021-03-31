# frozen_string_literal: true

require 'pg'

class DatabaseConnection
  def self.setup(dbname:)
    @connection = PG.connect(dbname: dbname)
  end

  attr_reader :connection

  def self.query(query)
    @connection.exec(query)
  end
end
