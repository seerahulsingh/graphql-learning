class Types::QueryType < Types::BaseObject

  field :user, Types::UserType, null: true, description: "Retrieve a user by ID" do
    argument :id, ID, required: true, description: 'A user id'
  end

  def user(id:)
    User.where(id: id).first
  end

  field :post, Types::PostType, null: true, description: "Retrieve a post by ID" do
    argument :id, ID, required: true, description: 'A post id'
  end

  def post(id:)
    Post.where(id: id).first
  end

  field :comment, Types::CommentType, null: true, description: "Retrieve a comment by ID" do
    argument :id, ID, required: true, description: 'A comment id'
  end

  def comment(id:)
    Comment.where(id: id).first
  end

  field :login, String, null: true, description: "Login a user" do
    argument :email, String, required: true
    argument :password, String, required: true
  end

  def login(email:, password:)
    User.where(email: email).first&.authenticate(password)&.sessions&.create&.key
  end

  field :logout, Boolean, null: false, description: "Logout the current user"

  def logout
    Session.where(id: context[:session_id]).destroy_all
    true
  end

end
