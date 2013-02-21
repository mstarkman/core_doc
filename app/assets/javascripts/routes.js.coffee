#= require services/template_paths

resolves = @CoreDoc.resolves ||= {}

@CoreDoc.config [
  "$routeProvider",
  "$locationProvider",
  "TemplatePaths",
  ($routeProvider, $locationProvider, TemplatePaths) ->
    $locationProvider.html5Mode(true).hashPrefix('!')

    $routeProvider
      .when(
        '/',
        templateUrl: TemplatePaths["documents/index.html"],
        controller: "DocumentsCtrl",
        resolve: resolves["document.index"]
      )
      .when(
        '/documents',
        redirectTo: "/"
      )
      .when(
        '/documents/new',
        templateUrl: TemplatePaths["documents/new.html"],
        controller: "DocumentNewCtrl"
      )
      .when(
        '/documents/:parent_id/new',
        templateUrl: TemplatePaths["documents/new.html"],
        controller: "DocumentNewCtrl"
      )
      .when(
        '/documents/:id',
        templateUrl: TemplatePaths["documents/show.html"],
        controller: "DocumentCtrl",
        resolve: resolves["document.show"]
      )
      .when('/documents/:id/edit',
            templateUrl: TemplatePaths["documents/edit.html"],
            controller: "DocumentEditCtrl",
            resolve: resolves["document.edit"]
      )
      .otherwise(redirectTo: "/")
]
