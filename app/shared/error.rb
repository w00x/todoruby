module Shared
  class Error
    attr_accessor :code, :description, :status_code, :message, :fields, :request_id, :metadata

    def initialize(code, description, status_code, message, fields: [], request_id: nil,
                   metadata: [])
      @code = code
      @description = description
      @status_code = status_code
      @message = message
      @fields = fields
      @request_id = request_id
      @metadata = metadata
    end

    def as_json
      json = {
        'code' => @code,
        'description' => @description,
        'message' => @message,
        'request_id' => @request_id
      }
      json['fields'] = @fields if @fields
      json['metadata'] = @metadata if @metadata

      json
    end

    def to_json
      as_json.to_json
    end

    def ==(other)
      code == other.code && description == other.description && fields == other.fields
    end

    class << self
      def not_found(klass, id)
        new(
          0001,
          'NOT_FOUND',
          404,
          "The requested resource doesn't exist (#{klass} = #{id})"
        )
      end

      def standar_error(message, metadata = nil)
        new(
          0002,
          'STANDAR_ERROR',
          500,
          "Internal server error: #{message}",
          metadata: metadata
        )
      end
    end
  end
end
