module Shared
  module Infrastructure
    module Controller
      class JsonResponse
        def initialize(body = {}, status = 200, headers = {})
          @body = body
          @status = status
          @headers = headers.merge({'Content-Type' => 'application/json'})
        end

        def render
          return [@status, @headers, @body.map(&:to_json).to_json] if @body.is_a?(Array)
          [@status, @headers, @body.to_json]
        end

        def empty_render
          @status
        end
      end
    end
  end
end
