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

get('/projects')do
  @projects = Project.all()
  erb(:projects)
end

get('/projects/new')do
  erb(:project_form)
end

get('/projects/:id')do
  @project = Project.find(params.fetch('id').to_i())
  erb(:project)
end

delete("/projects/:id") do
  @project = Project.find(params["id"].to_i)
  @project.delete
  @projects = Project.all
  redirect ('/projects')
end


post("/projects") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  redirect('/projects')
end

patch("/project/edit/:id") do
  new_project_name = params.fetch("title")
  @project = Project.find(params["id"].to_i)
  @project.update({title: new_project_name})
  redirect('/projects')
end

get('/volunteers')do
  erb(:volunteers)
end
post('/volunteers')do
  @name = params.fetch("name")
  @volunteer = Volunteer.new({:name => name, :id => nil})
  @volunteer.save()
  @volunteers = Volunteer.all
  erb(:volunteers)
end
