class BulletinPolicy < ApplicationPolicy
  def index?
    return false unless user

    user.admin?
  end

  def edit?
    return false unless user

    user.admin? && user.id == record.user_id
  end

  alias create? index?
  alias new? index?
  alias publish? index?
  alias reject? index?
  alias archive? index?
  alias update? edit?
  alias to_moderate? edit?
end
