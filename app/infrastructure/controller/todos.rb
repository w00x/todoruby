module Infrastructure
  module Controller
    class Todos < ::Shared::Infrastructure::Controller::Application
      include ::Shared::ErrorHelper

      def initialize(sinatra, todo_application)
        super(sinatra)
        @todo_application = todo_application
      end

      def index
        todo_list_dto = ::Infrastructure::Dto::TodoDto.todo_list_to_todo_list_dto(
          @todo_application.all
        )
        render(todo_list_dto)
      end

      def show
        todo = @todo_application.show(params[:id])
        render(::Infrastructure::Dto::TodoDto.from_domain(todo).as_json)
      rescue => e
        rescue_from(e)
      end

      def create
        todo = @todo_application.create(
          ::Infrastructure::Dto::TodoDto.from_hash(params).to_domain
        )
        render(::Infrastructure::Dto::TodoDto.from_domain(todo).as_json, 201)
      rescue => e
        rescue_from(e)
      end

      def update
        todo_updated = @todo_application.update(
          ::Infrastructure::Dto::TodoDto.from_hash(params).to_domain
        )
        render(::Infrastructure::Dto::TodoDto.from_domain(todo_updated).as_json)
      rescue => e
        rescue_from(e)
      end

      def delete
        @todo_application.delete(params[:id])
        empty_render
      rescue => e
        rescue_from(e)
      end

      def toggle
        todo = @todo_application.toggle(params[:id])
        render(::Infrastructure::Dto::TodoDto.from_domain(todo).as_json)
      rescue => e
        rescue_from(e)
      end
    end
  end
end
