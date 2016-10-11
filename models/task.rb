require 'mongoid'

class Task
  include Mongoid::Document

  field :title, type: String, default: ->{ 'undefined' }
  field :created_at, type: DateTime, default: -> { DateTime.new }
end
