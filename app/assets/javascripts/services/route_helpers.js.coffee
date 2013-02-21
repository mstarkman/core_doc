@CoreDoc.constant 'RouteHelpers',
  routes =
    documents:              -> "/documents"
    document:
      show:     (document)  -> if document then "/documents/#{document.slug}" else ""
      new:                  -> "/documents/new"
      newChild: (document)  -> "/documents/#{document.slug}/new"
      edit:     (document)  -> "/documents/#{document.slug}/edit"