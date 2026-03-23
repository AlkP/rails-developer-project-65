class CategoryPolicy < ApplicationPolicy
  def index?
    return false unless user

    user.admin?
  end

  alias create? index?
  alias edit? index?
  alias destroy? index?
  alias update? index?
  alias new? index?
end
