module Infrastructure
  module Repository
    class RepositoryFactory
      REPOSITORY_TYPES = {
        file: FileRepository::Todo.new
      }

      def self.build(type)
        raise NameError, "#{type} doesn't exist" unless REPOSITORY_TYPES.key?(type)

        REPOSITORY_TYPES[type]
      end
    end
  end
end
