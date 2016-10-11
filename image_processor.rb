require 'sinatra/base'
require 'sinatra/param'
require 'sinatra/json'
require 'sinatra-initializers'
require 'dotenv'

require './models/task'
require './serializers/task_serializer'

Dotenv.load

class ImageProcessor < Sinatra::Application
  register Sinatra::Initializers

  configure do
    set :raise_sinatra_param_exceptions, true
    set show_exceptions: false
  end

  before do
    content_type :json
  end

  get '/tasks' do
      json Task.order_by(created_at: :desc)
  end

  get '/tasks/:id' do
      param :id, String, required: true

      return json task_by_id! params['id']
  end

  post '/tasks' do
      param :title, String, required: true

      task = Task.new params
      task.save!

      json task
  end

  delete '/tasks/:id' do
      param :id, String, required: true

      task_by_id!(params['id']).destroy!
  end

  error Sinatra::Param::InvalidParameterError do
      status 422
      { error: "#{env['sinatra.error'].param} is invalid" }.to_json
  end

  error Mongoid::Errors::DocumentNotFound do
    status 404
    { error: "Not found" }.to_s
  end

  private

  def task_by_id!(id)
      task = Task.find(params['id'])
      if task != nil then
          task
      else
          raise Mongoid::Errors::DocumentNotFound.new
      end
  end

end
