@CoreDoc.directive "cdShowWithFade", [ ->
  (scope, element, attrs) ->
    # just keeping this around for use
    #fadeOutAttrs = scope.$eval(attrs.cdFadeOut)

    scope.$watch attrs.cdShowWithFade, (newVal, oldVal) ->
      if newVal
        $(element).show()
      else
        if newVal is oldVal
          $(element).hide()
        else
          $(element).fadeOut('fast')
]
