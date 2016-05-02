require 'faker'
require 'pg'

conn = PG.connect(dbname: "thewikinian")

conn.exec("DROP TABLE IF EXISTS articles")

conn.exec("CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  c_id INTEGER NOT NULL,
  original_body TEXT NOT NULL
  )"
) # Break categories up into table

5.times do |x|
  article_title = Faker::Hipster.sentence
  article_author_id = x+1
  article_ob = Faker::Hipster.paragraph(2)

  conn.exec_params("INSERT INTO articles (title, c_id, original_body) VALUES ($1, $2, $3)",
    [article_title, article_author_id, article_ob])
end
