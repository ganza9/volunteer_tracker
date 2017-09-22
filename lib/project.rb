class Project
  attr_accessor(:name, :volunteer_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @volunteer_id = attributes.fetch(:volunteer_id)
    @id = attributes.fetch(:id)
  end

  def ==(another_project)
    self.name().==(another_project.name()).&(self.volunteer_id().==(another_project.volunteer_id()))
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch('name')
      volunteer_id = project.fetch('volunteer_id')
      id = project.fetch('id').to_i
      attributes = {:name => name, :volunteer_id => volunteer_id, :id => id}
      projects.push(project.new(attributes))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find
    found_project = nil
    project.all().each() do |project|
      if project.id().==(id)
        found_project = project
      end
    end
    found_project
  end
end
