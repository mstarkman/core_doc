class Document < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :child_documents, class_name: "Document", foreign_key: :parent_document_id
  belongs_to :parent_document, class_name: "Document", foreign_key: :parent_document_id

  def self.without_parent
    where parent_document_id: nil
  end
end
