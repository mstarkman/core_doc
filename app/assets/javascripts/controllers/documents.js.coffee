@CoreDoc.controller 'DocumentsCtrl', ["$scope", "Document", ($scope, Document) ->
  docsOnSuccess = (results) ->
    $scope.documents = results

  docsOnFailure = (error) ->

  docs = Document.query()
  docs.then docsOnSuccess, docsOnFailure
]
