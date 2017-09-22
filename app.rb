require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/')do
  erb(:index)
end

get('/volunteers')do
  @volunteers = Volunteers.all()
  erb(:volunteers)
end

get('/volunteers/new')do
  erb(:volunteers_form)
end

get('/volunteer/:id')do
  @volunteer = Volunteer.find(params.fetch(:id).to_i)
end

post('/volunteers')do
  name = params.fetch("name")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save()
  erb(:success)
end

post('/projects')do
  name = params.fetch("name")
  volunteer_id = params.fetch("volunteer_id").to_i()
  @volunteer = Volunteer.find(volunteer_id)
  @project = Project.new({:name => name, :project_id => project_id, :id => nil})
  @project.save()
  erb(:success)
end
