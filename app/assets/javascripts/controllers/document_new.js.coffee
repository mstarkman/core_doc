@CoreDoc.controller 'DocumentNewCtrl', ["$scope", "$location", "Document", ($scope, $location, Document) ->
  document = $scope.document = new Document()
  $scope.addDocument = ->
    document.create().then ->
      $location.path "/documents/#{document.id}"
]
