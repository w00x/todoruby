def initialize_todo_controller(sinatra)
  @todo_repository = Infrastructure::Repository::RepositoryFactory.build(:sql_db)
  @todo_application = Application::TodoApplication.new(@todo_repository)
  Infrastructure::Controller::Todos.new(sinatra, @todo_application)
end
