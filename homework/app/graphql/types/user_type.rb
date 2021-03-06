class Types::UserInputType < Types::BaseInputObject
  description "All the attributes for a User"
  graphql_name "UserInputType"

  argument :id, ID, required: false, description: "The record ID, used only for updates"
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :street, String, required: false
  argument :number, String, required: false
  argument :postcode, String, required: false
  argument :city, String, required: false
  argument :country, String, required: false
end

class Types::UserType < Types::BaseObject
  description "A User"

  field :id, ID, null: true # the id is nil when a validation error has occurred
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :street, String, null: true
  field :number, String, null: true
  field :postcode, String, null: true
  field :city, String, null: true
  field :country, String, null: true

  field :created_at, String, null: false

  def created_at
    object.created_at.iso8601 # easily parsed by Javascript
  end

  field :address, String, null: true, description: "A concatenation of the present address components"

  # We intentionally exclude any address component that is nil, empty or made only of whitespaces
  # and we join the rest using a comma.
  def address
    ([:street, :number, :postcode, :city, :country].map do |a|
      object.send(a)&.strip
    end.compact - ['']).join(', ')
  end

  field :posts, [Types::PostType], null: true, description: "A user's posts"

  field :errors, [Types::ErrorType], null: true, description: "Record validation errors"
  def errors
    object.errors.map { |e| {field_name: e, errors: object.errors[e]}}
  end
end