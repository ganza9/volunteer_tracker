class Volunteer
  attr_accessor(:name)

  def initialize(attributes)
    @name = attributes.fetch(:name)
  end

end
