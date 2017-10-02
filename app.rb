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
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

get('/volunteers/new')do
  erb(:volunteer_form)
end

get('/volunteer/:id')do
  @volunteer = Volunteer.find(params.fetch(:id).to_i)
  erb(:volunteer_detail)
end

post('/volunteers')do
  name = params.fetch("name")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save()
  erb(:success)
end

get('/projects')do
  @projects = Projects.all()
  erb(:projects)
end

get('/projects/new')do
  erb(:project_form)
end

get('/projects/:id')do
  @project = Project.find(params.fetch('id').to_i())
  erb(:project_detail)
end

delete("/projects/:id") do
  @project = Project.find(params["id"].to_i)
  @project.delete
  @projects = Project.all
  redirect '/projects'
end

post('/projects')do
  title = params.fetch("title")
  volunteer_id = params.fetch("volunteer_id").to_i()
  @volunteer = Volunteer.find(volunteer_id)
  @project = Project.new({:title => title, :project_id => project_id, :id => nil})
  @project.save()
  erb(:success)
end

get("/project/edit/:id") do
  @project = Project.find(params['id'].to_i)
  @projects = Project.all
  erb(:project_edit)
end
