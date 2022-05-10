require_relative 'config'

module Infrastructure
  module Repository
    module SqlDb
      class Todo < Domain::Repository::Todo
        def all
          Model::Todo.all.map do |todo|
            ::Domain::Todo.new(todo.id, todo.title, todo.body, todo.completed)
          end
        end

        def find(id)
          todo = Model::Todo.find_by(id: id)
          unless todo
            raise ::Domain::Repository::Exceptions::NotFound.new('todoRepository', id)
          end
          ::Domain::Todo.new(todo.id, todo.title, todo.body, todo.completed)
        end

        def create(todo)
          todos_model = ::Infrastructure::Repository::Model::TodoModel.model_from_domain(todo)
          todo = Model::Todo.new(todos_model.as_json)
          unless todo.save
            raise ::Infrastructure::Repository::Exceptions::SqlDb::Exceptions::ActiveRecordError
                    .new(todo)
          end
          todos_model.to_domain
        end

        def update(todo)
          current_todo = find(todo.id)
          current_todo.title = todo.title unless todo.title.nil?
          current_todo.body = todo.body unless todo.body.nil?
          current_todo.completed = todo.completed unless todo.completed.nil?

          update_todo = Model::Todo.find_by(id: current_todo.id)
          update_todo.title = current_todo.title
          update_todo.body = current_todo.body
          update_todo.completed = current_todo.completed

          unless update_todo.save
            raise ::Infrastructure::Repository::Exceptions::SqlDb::Exceptions::ActiveRecordError
                    .new(todo)
          end

          current_todo
        end

        def delete(id)
          todo = find(id)
          delte_todo = Model::Todo.find_by(id: todo.id)
          unless delte_todo.delete
            raise ::Infrastructure::Repository::Exceptions::SqlDb::Exceptions::ActiveRecordError
                    .new(todo)
          end
        end
      end
    end
  end
end
