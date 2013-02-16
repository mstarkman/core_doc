@CoreDoc.controller 'DocumentCtrl', ["$scope", "Document", ($scope, Document) ->
  $scope.document = Document.loadedDocument
]

@CoreDoc.resolves["document.show"] =
  data: ["$q", "$route", "Document", ($q, $route, Document) ->
    defer = $q.defer()

    Document.get($route.current.pathParams.id).then (document) ->
      Document.loadedDocument = document
      defer.resolve()

    defer.promise
  ]
