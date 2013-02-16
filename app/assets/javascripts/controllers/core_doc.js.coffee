#= require_tree .

@CoreDoc.controller 'CoreDocCtrl', [
  "$rootScope",
  "$timeout",
  "TemplatePaths",
  ($rootScope, $timeout, TemplatePaths) ->
    $rootScope.templatePaths = TemplatePaths

    $rootScope.isLoading = false
    $rootScope.isShowingFlash = false
    startedLoading = false
    startedSaving = false
    $rootScope.flashMessage = null
    $rootScope.saveMessage = null
    $rootScope.isSaving = false

    showFlashMessage = ->
      if $rootScope.flashMessage?
        $rootScope.isShowingFlash = true
        $timeout ->
          $rootScope.isShowingFlash = false
          $rootScope.flashMessage = null
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
