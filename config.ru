require './config/environment'

if ActiveRecord::Migrator.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UsersControllers
run ApplicationController
