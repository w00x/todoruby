module Infrastructure
  module Repository
    module FileRepository
      class Todo < Domain::Repository::Todo
        DB_FILE_PATH = "#{__dir__}/db.json".freeze

        def initialize
          @todos = JSON.parse(File.read(DB_FILE_PATH))
        end

        def all
          get_raw_json.map do |todo|
            ::Infrastructure::Repository::Model::TodoModel.model_from_hash(todo).to_domain
          end
        end

        def find(id)
          todo_finded = all.find do |todo|
            todo.id == id
          end
          unless todo_finded
            raise ::Domain::Repository::Exceptions::NotFound.new('todoRepository', id)
          end
          todo_finded
        end

        def create(todo)
          @todos << ::Infrastructure::Repository::Model::TodoModel.model_from_domain(todo).as_json
          save_json
          todo
        end

        def update(todo)
          current_todo = find(todo.id)
          current_todo.title = todo.title unless todo.title.nil?
          current_todo.body = todo.body unless todo.body.nil?
          current_todo.completed = todo.completed unless todo.completed.nil?

          @todos.each_with_index do |item, index|
            if item['id'] == todo.id
              @todos[index] = ::Infrastructure::Repository::Model::TodoModel.model_from_domain(current_todo)
                                                                            .as_json
              break
            end
          end
          save_json
          current_todo
        end

        def delete(id)
          todo_finded = find(id)
          @todos.delete(
            ::Infrastructure::Repository::Model::TodoModel.model_from_domain(todo_finded).as_json
          )
          save_json
          true
        end

        private

        def get_raw_json
          @todos = JSON.parse(File.read(DB_FILE_PATH))
        end

        def save_json
          File.write(DB_FILE_PATH, @todos.to_json)
        end
      end
    end
  end
end
