class BulletinPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  alias_method :create?, :index?
  alias_method :new?, :index?
end
