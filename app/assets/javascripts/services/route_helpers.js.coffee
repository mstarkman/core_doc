@CoreDoc.constant 'RouteHelpers',
  routes =
    documents:              -> "/documents"
    document:
      show:     (document)  -> if document then "/documents/#{document.id}" else ""
      new:                  -> "/documents/new"
      newChild: (document)  -> "/documents/#{document.id}/new"
      edit:     (document)  -> "/documents/#{document.id}/edit"