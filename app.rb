require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'

# db setup
before do
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do
  @db.close
end

get '/'  do
    erb :index 
end

get '/new'  do
 erb :new
end

get '/create'  do
    @title = params[:title]
    @description = params[:description]
    @youtube_id = params[:youtube_id]
    @genre = params[:genre]

    sql = "insert into videos(title, description, youtube_id, genre) values('#{@title}', '#{@description}', '#{@youtube_id}', '#{@genre}') returning *"
    @db.exec(sql)

  redirect '/show'
end

get '/show' do

  sql="select * from videos order by title"
  @videos = @db.exec(sql)

  erb :show
end

get '/delete/:youtube_id' do
  @youtube_id = params[:youtube_id]
  sql = "delete from videos where youtube_id = '#{@youtube_id}'"
  @db.exec(sql)
  
  redirect '/show'

end

# get '/edit/:youtube_id' do
#   @youtube_id = params[:youtube_id]
#   sql = "delete from videos where youtube_id = '#{@youtube_id}'"
#   @db.exec(sql)

# end


