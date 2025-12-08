# frozen_string_literal: true

module StatementTimeout
  class Configuration
    class_attribute :default_mode
    self.default_mode = :session
  end
end
