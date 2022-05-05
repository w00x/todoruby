require 'securerandom'

module Domain
  class Todo
    attr_accessor :id, :title, :body, :completed

    def initialize(id, title, body, completed)
      id = SecureRandom.uuid if id.nil?
      @id = id
      @title = title
      @body = body
      @completed = completed
    end
  end
end
