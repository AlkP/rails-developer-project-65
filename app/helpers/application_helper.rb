module ApplicationHelper
  def admin?
    controller.class.name.start_with?('Admin::') || controller.class.name.eql?('AdminController')
  end

  def active?(name)
    controller.class.name.end_with?(name) ? 'btn-primary active' : 'btn-outline-secondary'
  end
end
