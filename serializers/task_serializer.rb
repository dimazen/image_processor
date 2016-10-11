require 'active_model_serializers'

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at

  def id
      object.id.to_s
  end

  def created_at
      object.created_at.strftime('%FT%T%:z')
  end
end
