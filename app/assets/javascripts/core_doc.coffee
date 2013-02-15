app = angular.module("CoreDoc", ['rails'])

app.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true).hashPrefix('!')

  $routeProvider
    .when('/', templateUrl: "documents.html", controller: "DocumentsCtrl")
    .when('/documents', redirectTo: "/")
    .when('/documents/new', templateUrl: "documentNew.html", controller: "DocumentNewCtrl")
    .when('/documents/:id', templateUrl: "/templates/document/show", controller: "DocumentCtrl")
    #.when('/documents/:id', templateUrl: "document.html", controller: "DocumentCtrl")
    .when('/documents/:id/edit', templateUrl: "documentEdit.html", controller: "DocumentEditCtrl")
    .otherwise(redirectTo: "/")
]

app.factory 'Document', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory url: '/documents', name: 'document'
]

app.controller 'DocumentsCtrl', ["$scope", "Document", ($scope, Document) ->
  docsOnSuccess = (results) ->
    $scope.documents = results

  docsOnFailure = (error) ->

  docs = Document.query()
  docs.then docsOnSuccess, docsOnFailure
]

app.controller 'DocumentCtrl', ["$scope", "$routeParams", "Document", ($scope, $routeParams, Document) ->
  id = $routeParams.id
  Document.get(id).then (document) ->
    $scope.document = document
]

app.controller 'DocumentNewCtrl', ["$scope", "$location", "Document", ($scope, $location, Document) ->
  $scope.addDocument = ->
    document = new Document($scope.document)

    document.create().then ->
      $location.path "/documents/#{document.id}"
]

app.controller 'DocumentEditCtrl', ["$scope", "$location", "$routeParams", "Document", ($scope, $location, $routeParams, Document) ->
  id = $routeParams.id
  currentDocument = null

  Document.get(id).then (document) ->
    $scope.currentTitle = document.title
    $scope.document = currentDocument = document

  $scope.saveDocument = ->
    currentDocument.update().then (document) ->
      $location.path "/documents/#{document.id}"

  $scope.deleteDocument = ->
    if confirm("Are you sure you want to delete \"#{currentDocument.title}\"?")
      currentDocument.delete().then ->
        $location.path '/documents'
]


