Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, function: Mutations::CreateUser.new
  field :updateUser, function: Mutations::UpdateUser.new
  field :deleteUser, function: Mutations::DeleteUser.new

  field :createPost, function: Mutations::CreatePost.new
  field :updatePost, function: Mutations::UpdatePost.new
  field :deletePost, function: Mutations::DeletePost.new

  field :createComment do
    argument :comment, Types::CommentInputType

    type Types::CommentType

    must_be [:member]

    resolve ->(obj, args, cts) do
      Comment.create args[:comment].to_h
    end
  end

  field :updateComment, function: Mutations::UpdateComment.new
  field :deleteComment, function: Mutations::DeleteComment.new

  field :logout, types.Boolean do
    resolve ->(_, _, ctx) { Session.where(key: ctx[:session_key]).destroy_all }
  end
end
