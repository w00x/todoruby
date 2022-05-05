module Shared
  module Common
    module Todo
      def as_json
        {
          id: @id,
          title: @title,
          body: @body,
          completed: @completed
        }
      end

      def to_json
        as_json
      end

      def to_domain
        ::Domain::Todo.new(@id, @title, @body, @completed)
      end
    end
  end
end
