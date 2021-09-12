Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :user, Types::UserType do
    argument :id, types.ID
    resolve ->(_, a, _) { User.find(a[:id]) }
  end

  field :login, types.String do
    argument :email, types.String
    argument :password, types.String

    is_public true

    resolve ->(_, args, _) {
      user = User.where(email: args[:email]).first
      user.sessions.create.key if user.try(:authenticate, args[:password])
    }
  end
end
