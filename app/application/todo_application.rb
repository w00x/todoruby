module Application
  class TodoApplication
    def initialize(todo_repository)
      @todo_repository = todo_repository
    end

    def all
      @todo_repository.all
    end

    def show(id)
      @todo_repository.find(id)
    end

    def create(todo)
      @todo_repository.create(todo)
    end

    def update(todo)
      @todo_repository.update(todo)
    end

    def delete(id)
      @todo_repository.delete(id)
    end

    def toggle(id)
      todo = @todo_repository.find(id)
      todo.completed = !todo.completed
      @todo_repository.update(todo)
    end
  end
end
