# frozen_string_literal: true

require 'active_support'
require 'active_record'

require_relative 'statement_timeout/configuration'
require_relative 'statement_timeout/version'
require_relative 'statement_timeout/railtie'

module StatementTimeout
  module AbstractAdapterExtension
    def supports_statement_timeout? = false
    def statement_timeout           = raise NotImplementedError

    def statement_timeout=(timeout)
      raise NotImplementedError
    end

    def local_statement_timeout=(timeout)
      raise NotImplementedError
    end
  end

  module PostgreSQLAdapterExtension
    def supports_statement_timeout? = true
    def statement_timeout           = @statement_timeout ||= query_value("SHOW statement_timeout")
    def statement_timeout=(timeout)
      @statement_timeout = nil

      internal_exec_query("SET statement_timeout = #{quote(timeout)}")
    end

    def local_statement_timeout=(timeout)
      @statement_timeout = nil

      internal_exec_query("SET LOCAL statement_timeout = #{quote(timeout)}")
    end
  end

  module QueryMethodsExtension
    def statement_timeout(timeout, mode: StatementTimeout.config.default_mode)
      timeout = if timeout in ActiveSupport::Duration
                  timeout.in_milliseconds
                else
                  timeout
                end

      connection_pool.with_connection do |connection|
        raise ActiveRecord::AdapterError, "statement_timeout is not supported for the #{connection.class.inspect} adapter" unless
          connection.supports_statement_timeout?

        case mode
        when :transaction
          connection.transaction do
            connection.local_statement_timeout = timeout

            yield connection
          end
        when :session
          begin
            statement_timeout_was, connection.statement_timeout = connection.statement_timeout, timeout

            yield connection
          ensure
            connection.statement_timeout = statement_timeout_was
          end
        else
          raise ArgumentError, "mode is not supported: #{mode.inspect}"
        end
      end
    end
  end

  module QueryingExtension
    delegate :statement_timeout, to: :all
  end

  def self.config = @config ||= Configuration.new
  def self.configure
    yield config
  end
end

