module Domain
  module Repository
    module Exceptions
      class NotFound < Error
        attr_reader :klass, :id

        def initialize(klass, id, msg = nil)
          super(msg)
          @klass = klass
          @id = id
        end
      end
    end
  end
end
