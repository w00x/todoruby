require_relative 'injector'

module Routes
  Sinatra::Base::get('/v1/todo') do
    initialize_todo_controller(self).index
  end

  Sinatra::Base::get('/v1/todo/:id') do
    initialize_todo_controller(self).show
  end

  Sinatra::Base::post('/v1/todo') do
    initialize_todo_controller(self).create
  end

  Sinatra::Base::patch('/v1/todo/:id') do
    initialize_todo_controller(self).update
  end

  Sinatra::Base::delete('/v1/todo/:id') do
    initialize_todo_controller(self).delete
  end

  Sinatra::Base::get('/v1/todo/toggle/:id') do
    initialize_todo_controller(self).toggle
  end
end
