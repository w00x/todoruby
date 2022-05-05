module Shared
  module ErrorHelper
    def rescue_from(error, type = :json)
      if error.is_a?(::Domain::Repository::Exceptions::NotFound)
        render_error(Error.not_found(error.klass, error.id), type)
      elsif error.is_a?(StandardError)
        render_error(
          Error.standar_error(
            error.message, error.backtrace
          ),
          type
        )
      end
    end

    def render_error(error, type = :json)
      json_response = ::Shared::Infrastructure::Controller::JsonResponse.new(
        error.as_json,error.status_code
      ).render

      case type
      when :json
        return json_response
      else
        return json_response
      end
    end
  end
end
