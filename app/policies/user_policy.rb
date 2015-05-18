class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.reject { |u| u == user }
    end
  end

  def update?
    user == record || user.admin?
  end

  def ask_for_code?
    true
  end

  def accept_request?
    true
  end

  def decline_request
    true
  end

  def show?
    user.friends.include?(record) || user.admin? || user == record
  end
end
