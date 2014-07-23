require 'lib/base'

module BackendClient
  class DigitalItem < Base
    extend DefaultAll
    extend DefaultFind
    extend DefaultCreate
    include DefaultUpdate
    include DefaultActivate
    include DefaultDelete
  end
end