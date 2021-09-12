class Types::CoordinatesType < Types::BaseObject
  field :latitude, Float, null: true
  field :longitude, Float, null: true

  def latitude
    object.first
  end

  def longitude
    object.last
  end

  def self.authorized?(object, context)
    object.first > 10 && object.last < 10
  end

end