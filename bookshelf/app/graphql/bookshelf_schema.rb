class BookshelfSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(error)
    raise GraphQL::ExecutionError, "Permissions configuration do not allow the object you requested, of type #{error.type.graphql_name}"
  end
end
