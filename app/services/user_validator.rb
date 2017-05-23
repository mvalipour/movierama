# Mimics ActiveModel::Validator (to an extent)
class UserValidator
  def initialize(user)
    @user = user
    @errors = nil
  end

  def valid?
    errors.empty?
  end

  def errors
    return @errors if @errors
    @errors = {}

    if @user.name.blank?
      @errors[:name] = true
    end

    @errors
  end

  def class_for(field)
    errors[field] ? "has-error" : ""
  end
end
