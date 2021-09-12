class Types::MutationType < Types::BaseObject

  ### User

  field :create_user, Types::UserType, null: true, description: "Create a user" do
    argument :user, Types::UserInputType, required: true, description: "All the attributes required to create a user"
  end

  def create_user(user:)
    User.create user.to_h
  end

  field :update_user, Boolean, null: false, description: "Update a user" do
    argument :user, Types::UserInputType, required: true, description: "All the attributes required to update a user, including ID"
  end

  def update_user(user:)
    User.where(id: user[:id]).first&.update(user.to_h.without(:id))
  end

  field :delete_user, Boolean, null: false, description: "Delete a user" do
    argument :id, ID, required: true, description: "The ID of the user to delete"
  end

  def delete_user(id:)
    User.where(id: id).destroy_all
    true
  end

  field :create_post, Types::PostType, null: true, description: "Create a post" do
    argument :post, Types::PostInputType, required: true, description: "All the attributes required to create a post"
  end

  ### Post

  def create_post(post:)
    Post.create post.to_h
  end

  field :update_post, Boolean, null: false, description: "Update a post" do
    argument :post, Types::PostInputType, required: true, description: "All the attributes required to update a post, including ID"
  end

  def update_post(post:)
    Post.where(id: post[:id]).first&.update(post.to_h.without(:id))
  end

  field :delete_post, Boolean, null: false, description: "Delete a post" do
    argument :id, ID, required: true, description: "The ID of the post to delete"
  end

  def delete_post(id:)
    Post.where(id: id).destroy_all
    true
  end

  ### Comment

  field :create_comment, Types::CommentType, mutation: Mutations::CreateComment

  field :update_comment, Boolean, null: false, description: "Update a comment" do
    argument :comment, Types::CommentInputType, required: true, description: "All the attributes required to update a comment, including ID"
  end

  def update_comment(comment:)
    Comment.where(id: comment[:id]).first&.update(comment.to_h.without(:id))
  end

  field :delete_comment, Boolean, null: false, description: "Delete a comment" do
    argument :id, ID, required: true, description: "The ID of the comment to delete"
  end

  def delete_comment(id:)
    Comment.where(id: id).destroy_all
    true
  end
end
