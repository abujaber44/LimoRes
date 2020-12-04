class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :manage, :all 
    else
      can :create, Reservation do |r|
        r.user == user 
      end
      can :update, Reservation do |r|
        r.user == user 
      end
      can :destroy, Reservation do |r|
        r.user == user 
      end
      can :create, Address do |a|
        a.user == user 
      end
      can :update, Address do |a|
        a.user == user 
      end
      can :destroy, Address do |a|
        a.user == user 
      end 
    end
  end
end
