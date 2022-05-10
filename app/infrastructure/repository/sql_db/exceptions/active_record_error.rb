module Infrastructure
  module Repository
    module SqlDb
      module Exceptions
        class ActiveRecordError < Error
          attr_reader :model

          def initialize(model, msg = nil)
            super(msg)
            @model = model
          end
        end
      end
    end
  end
end
