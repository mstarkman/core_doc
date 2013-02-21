@CoreDoc.controller 'DocumentCtrl', ["$scope", "Document", ($scope, Document) ->
  $scope.document = Document.loadedDocument
]

@CoreDoc.resolves["document.show"] =
  data: [
    "$rootScope",
    "$q",
    "$route",
    "Document",
    ($rootScope, $q, $route, Document) ->
      defer = $q.defer()

      docOnSuccess = (document) ->
        Document.loadedDocument = document
        defer.resolve()

      docOnFailure = (response) ->
        # response.status = 404
        $rootScope.setFlashMessage "Error loading document!"
        defer.reject()

      doc = Document.get($route.current.pathParams.id)
      doc.then docOnSuccess, docOnFailure

      defer.promise
  ]
