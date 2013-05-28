def populate_db
  schema = File.open('../db/schema/import_db.sql')

  db = SQLite3::Database.new "questions_database.db"
  db.execute(schema.read)
end