class AddParentDocumentIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :parent_document_id, :integer
  end
end
