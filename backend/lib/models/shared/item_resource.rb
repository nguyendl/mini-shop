require 'models/shared/deletable'
require 'models/shared/displayable'
require 'models/shared/fulfillable'

module ItemResource
  extend ActiveSupport::Concern
  include Deletable
  include Displayable
  include Fulfillable

  module ClassMethods
    def paginate(offset = nil, limit = nil)
      offset(offset || 0).limit(limit || 20)
    end
  end

  def available?
    !deleted?
  end
end
