#= require_tree .

routes =
  documents:              -> "/documents"
  document:
    show:     (document)  -> if document then "/documents/#{document.id}" else ""
    new:                  -> "/documents/new"
    newChild: (document)  -> "/documents/#{document.id}/new"
    edit:     (document)  -> "/documents/#{document.id}/edit"

@CoreDoc.controller 'CoreDocCtrl', [
  "$rootScope",
  "$timeout",
  "TemplatePaths",
  ($rootScope, $timeout, TemplatePaths) ->
    $rootScope.templatePaths = TemplatePaths
    $rootScope.routes = routes

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
