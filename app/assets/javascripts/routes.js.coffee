#= require services/templates

resolves = @CoreDoc.resolves ||= {}

@CoreDoc.config [
  "$routeProvider",
  "$locationProvider",
  "Templates",
  ($routeProvider, $locationProvider, Templates) ->
    $locationProvider.html5Mode(true).hashPrefix('!')

    $routeProvider
      .when(
        '/',
        templateUrl: Templates["documents/index.html"],
        controller: "DocumentsCtrl",
        resolve: resolves["document.index"]
      )
      .when(
        '/documents',
        redirectTo: "/"
      )
      .when(
        '/documents/new',
        templateUrl: Templates["documents/new.html"],
        controller: "DocumentNewCtrl"
      )
      .when(
        '/documents/:parent_id/new',
        templateUrl: Templates["documents/new.html"],
        controller: "DocumentNewCtrl",
        resolve: resolves["document.newChild"]
      )
      .when(
        '/documents/:id',
        templateUrl: Templates["documents/show.html"],
        controller: "DocumentCtrl",
        resolve: resolves["document.show"]
      )
      .when('/documents/:id/edit',
            templateUrl: Templates["documents/edit.html"],
            controller: "DocumentEditCtrl",
            resolve: resolves["document.edit"]
      )
      .otherwise(redirectTo: "/")
]
