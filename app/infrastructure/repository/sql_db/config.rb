::ActiveRecord::Base.establish_connection(ENV['DATABASE_URI'])
::ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
