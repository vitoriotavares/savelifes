module ApplicationHelper
  def active?(controller)
    # binding.pry
    controller_name == controller ? 'active' : '' 
  end
end
