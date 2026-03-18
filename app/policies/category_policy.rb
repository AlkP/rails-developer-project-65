class CategoryPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  alias create? index?
  alias edit? index?
  alias destroy? index?
  alias update? index?
  alias new? index?
end
