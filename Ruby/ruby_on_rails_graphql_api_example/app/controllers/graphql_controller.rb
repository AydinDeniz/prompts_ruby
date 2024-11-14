
class GraphqlController < ApplicationController
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Provide any context you need for your GraphQL API here
    }
    result = MovieDatabaseSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String then JSON.parse(variables_param)
    when Hash, ActionController::Parameters then variables_param
    when nil then {}
    else raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
end
