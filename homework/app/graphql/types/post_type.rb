class Types::PostInputType < Types::BaseInputObject
  description "The attributes to create a post"
  graphql_name "PostInputType"

  argument :id, ID, required: false, description: "The record ID, used only for updates"
  argument :user_id, ID, required: false, description: "The ID of the user who publishes this post (only required to create a record)"
  argument :body, String, required: true
end

class Types::PostType < Types::BaseObject
  description "A blog post"

  field :id, ID, null: false
  field :user, Types::UserType, null: false, description: "The author of the post"
  field :body, String, null: true, description: "The contents of the post"

  field :created_at, String, null: false
  def created_at
    object.created_at.iso8601 # easily parsed by JavaScript
  end

  field :comments, [Types::CommentType], null: true, description: "Comments to this post"
end
