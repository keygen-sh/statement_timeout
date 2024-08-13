# frozen_string_literal: true

require 'active_record/connection_adapters/postgresql_adapter'
require 'active_record/relation'

module StatementTimeout
  ActiveSupport.on_load :active_record do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AbstractAdapterExtension)
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(PostgreSQLAdapterExtension)
    ActiveRecord::QueryMethods.prepend(QueryMethodsExtension)
    ActiveRecord::Querying.prepend(QueryingExtension)
  end
end

