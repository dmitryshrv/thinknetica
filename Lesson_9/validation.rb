module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, valitation_type, *validation_params)
      @validations ||= {}
      params = {
        name: name, valitation_type: valitation_type, valitation_params: validation_params
      }
      instance_variable_set(:name, validations << params)
    end

    attr_reader :validations
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      validations.each do |name, parameters|
        parameters.each do |validation|
          validation_type = validation[:validation_type]
          validation_option = validation[:validation_params]
          send("validate_#{validation_type}", instance_variable_get("@#{name}"), validation_option)
        end
      end
    end

    def validate_type(value, type)
      raise 'Неверный тип' unless value.is_a?(type)
    end

    def validate_presence(value, option)
      raise 'Должно быть значение' if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise 'Некорректный формат!' if value !~ format
    end
  end
end
