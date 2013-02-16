@CoreDoc.controller 'DocumentsCtrl', [
  "$scope",
  "$route",
  "Document",
  ($scope, $route, Document) ->
    $scope.documents = Document.loadedDocuments if Document.loadedDocuments?
]

@CoreDoc.resolves["document.index"] =
  data: ["$q", "Document", ($q, Document) ->
    defer = $q.defer()

    docsOnSuccess = (results) ->
      Document.loadedDocuments = results
      defer.resolve()
    docsOnFailure = (error) -> defer.reject()

    docs = Document.query()
    docs.then docsOnSuccess, docsOnFailure

    defer.promise
  ]

