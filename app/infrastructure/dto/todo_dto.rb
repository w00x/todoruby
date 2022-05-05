module Infrastructure
  module Dto
    class TodoDto
      include ::Shared::Common::Todo
      attr_accessor :id, :title, :body, :completed

      def initialize(id, title, body, completed)
        @id = id
        @title = title
        @body = body
        @completed = completed
      end

      class << self
        def todo_list_to_todo_list_dto(todo_list)
          todo_list.map { |todo| self.from_domain(todo) }
        end

        def from_domain(todo)
          TodoDto.new(todo.id, todo.title, todo.body, todo.completed)
        end

        def from_hash(todo_hash)
          TodoDto.new(todo_hash['id'], todo_hash['title'], todo_hash['body'],todo_hash['completed'])
        end
      end
    end
  end
end
