module Infrastructure
  module Repository
    module Model
      class TodoModel
        include ::Shared::Common::Todo
        attr_accessor :id, :title, :body, :completed

        def initialize(id, title, body, completed)
          @id = id
          @title = title
          @body = body
          @completed = completed
        end

        class << self
          def model_from_domain(todo)
            TodoModel.new(todo.id, todo.title, todo.body, todo.completed)
          end

          def model_from_hash(todo_hash)
            TodoModel.new(todo_hash['id'], todo_hash['title'], todo_hash['body'],todo_hash['completed'])
          end
        end
      end
    end
  end
end
