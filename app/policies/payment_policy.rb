class PaymentPolicy
  attr_reader :user, :object

  def initialize(user, object)
    raise Pundit::NotAuthorizedError unless user.admin?

    @user = user
    @object = object
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    !object.declined? && !object.executed?
  end

  def update?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def accept?
    true
  end

  def decline?
    true
  end

  def scope
    Pundit.policy_scope!(user, object.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
