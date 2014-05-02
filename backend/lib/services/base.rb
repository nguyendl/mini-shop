require 'services/shared/errors'
require 'services/shared/helpers'
require 'sinatra/namespace'

module Services
  class Base < Sinatra::Base
    register Sinatra::RespondTo
    register Sinatra::Namespace
    helpers Services::Errors
    helpers Services::Helpers

    configure do
      set :default_content, :json
      disable :show_exceptions
      disable :raise_errors
      disable :dump_errors
    end
  end
end