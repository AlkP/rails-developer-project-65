class BulletinPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  alias create? index?
  alias new? index?
  alias publish? index?
  alias reject? index?
  alias archive? index?
end
