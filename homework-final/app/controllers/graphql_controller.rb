class GraphqlController < ApplicationController

  before_action :check_authentication

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
        current_user: @session.try(:user),
        session_key: @session.try(:key)
    }
    result = BHomeworkSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def check_authentication
    parsed_query = GraphQL::Query.new BHomeworkSchema, params[:query]
    operation = parsed_query.selected_operation.selections.first.name
    return true if operation == '__schema'

    field = BHomeworkSchema.query.fields[operation] || BHomeworkSchema.mutation.fields[operation]
    return true if field.metadata[:is_public]

    unless @session = Session.where(key: request.headers['Authorization']).first
      head(:unauthorized)
      return false
    end

    must_be = field.metadata[:must_be].to_a
    unless must_be.empty? || must_be.include?(@session.user.role)
      head(:unauthorized)
      return false
    end
  end
end
