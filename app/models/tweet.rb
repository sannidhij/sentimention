class Tweet
  include Mongoid::Document
  field :original, type: String
end