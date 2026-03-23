module ApplicationHelper
  def admin?
    controller.class.name.start_with?('Web::Admin::') || controller.instance_of?(::AdminController)
  end

  def class_of(name)
    controller.class.name.end_with?(name) ? 'btn-primary active' : 'btn-outline-secondary'
  end
end
