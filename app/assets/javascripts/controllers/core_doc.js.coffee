#= require_tree .

@CoreDoc.controller 'CoreDocCtrl', [
  "$rootScope",
  "$timeout",
  "$location",
  "TemplatePaths",
  "RouteHelpers"
  ($rootScope, $timeout, $location, TemplatePaths, RouteHelpers) ->
    $rootScope.templatePaths = TemplatePaths
    routes = $rootScope.routes = RouteHelpers

    $rootScope.isLoading = false
    $rootScope.isShowingFlash = false
    startedLoading = false
    startedSaving = false
    flashSet = false
    $rootScope.flashMessage = null
    $rootScope.saveMessage = null
    $rootScope.isSaving = false

    showFlashMessage = ->
      if flashSet
        $rootScope.isShowingFlash = true
        $timeout ->
          flashSet = false
          $rootScope.isShowingFlash = false
        , 2000

    $rootScope.$on "$routeChangeStart", ->
      startedLoading = true
      $timeout ->
        $rootScope.isLoading = true if startedLoading
      , 250

    $rootScope.$on "$routeChangeSuccess", ->
      $rootScope.isLoading = startedLoading = false
      showFlashMessage()

    $rootScope.$on "$routeChangeError", ->
      $rootScope.isLoading = startedLoading = false
      $location.path routes.documents()
      showFlashMessage()

    $rootScope.setFlashMessage = (message) ->
      flashSet = true
      $rootScope.flashMessage = message

    $rootScope.startSaving = (message = "Saving...") ->
      startedSaving = true
      $timeout ->
        if startedSaving
          $rootScope.isSaving = true
          $rootScope.saveMessage = message
      , 250

    $rootScope.endSaving = (flashMessage = null) ->
      startedSaving = false
      $rootScope.isSaving = false
      $rootScope.saveMessage = null
      $rootScope.setFlashMessage(flashMessage) if flashMessage?

]
