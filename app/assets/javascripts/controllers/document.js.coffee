@CoreDoc.controller 'DocumentCtrl', ["$scope", "$routeParams", "Document", ($scope, $routeParams, Document) ->
  id = $routeParams.id
  Document.get(id).then (document) ->
    $scope.document = document
]
