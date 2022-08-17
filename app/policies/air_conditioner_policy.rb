class AirConditionerPolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end

  def controll?
    if record.owner_only
      user == record.user
    else
      user
    end
  end
end
