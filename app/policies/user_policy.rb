class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.reject { |u| u == user }
    end

    def update?
      user == record || user.admin?
    end

    def ask_for_code?
      true
    end

    def show?
      user.friends.include? record || user.admin?
    end
  end
end
