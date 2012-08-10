class UserAggregates
  include Mongoid::Document
  field :_id, type: Hash
  field :value, type: Hash
end