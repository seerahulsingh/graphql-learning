class Types::CommentInputType < Types::BaseInputObject
  description "The attributes to create a comment"
  graphql_name "CommentInputType"

  argument :id, ID, required: false, description: "The record ID, used only for updates"
  argument :post_id, ID, required: false, description: "The ID of the post on which this comment is published (only required to create a record)"
  argument :body, String, required: true
end

class Types::CommentType < Types::BaseObject
  description "A blog post comment"

  field :id, ID, null: false
  field :body, String, null: true, description: "The body of the comment"

  field :created_at, String, null: false
  def created_at
    object.created_at.iso8601 # easily parsed by Javascript
  end

end