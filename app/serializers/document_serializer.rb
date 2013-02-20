class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
