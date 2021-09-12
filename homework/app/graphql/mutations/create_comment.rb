class Mutations::CreateComment < GraphQL::Schema::Mutation
  null true

  argument :comment, Types::CommentInputType, required: true

  def resolve(comment:)
    Comment.create comment.to_h
  end

  def self.accessible?(context)
    'member' == context[:current_user]&.role
  end
end