module Shared
  module Infrastructure
    module Controller
      class Application
        def initialize(sinatra)
          @sinatra = sinatra
        end

        def params
          request_body = {}
          unless @sinatra.request.body.read.empty?
            request_body = JSON.parse(@sinatra.request.body.read)
          end
          @params ||= @sinatra.params.merge(request_body)
        end

        def render(body = {}, status = 200, type = :json)
          case type
          when :json
            return JsonResponse.new(body, status).render
          end
        end

        def empty_render(status = 204, type = :json)
          case type
          when :json
            return JsonResponse.new(nil, status).empty_render
          end
        end
      end
    end
  end
end
