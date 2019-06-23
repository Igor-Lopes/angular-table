class Table
  constructor: (@element, @tableConfiguration, @configurationVariableNames) ->

  constructHeader: () ->
    tr = angular.element(document.createElement("tr"))
    for i in @tableConfiguration.columnConfigurations
      tr.append(i.renderHtml())
    return tr

  setupHeader: () ->
    thead = @element.find("thead")
    if thead
      header = @constructHeader()
      tr = angular.element(thead).find("tr")
      tr.remove()
      thead.append(header)

  getSetup: () ->
    if @tableConfiguration.paginated
      return new PaginatedSetup(@configurationVariableNames)
    else
      return new StandardSetup(@configurationVariableNames, @tableConfiguration.list)
    return

  compile: () ->
    @setupHeader()
    @setup = @getSetup()
    @setup.compile(@element)

  setupInitialSorting: ($scope) ->
    for bd in @tableConfiguration.columnConfigurations
      if bd.initialSorting
        throw "initial-sorting specified without attribute." if not bd.attribute
        $scope.predicate = bd.attribute
        $scope.descending = bd.initialSorting == "desc"

  post: ($scope, $element, $attributes, $filter) ->
    @setupInitialSorting($scope)

    $scope.change = (event, predicate) ->
      console.log(event)
      console.log(angular.element(event.currentTarget).find('svg'))
      for th in angular.element(event.currentTarget).closest('tr').find('th')
        svg = angular.element(th).find('svg')
        if (svg.hasClass('fa-chevron-up') || svg.hasClass('fa-chevron-down'))
            svg.removeClass('fa-chevron-up')
            svg.removeClass('fa-chevron-down')
            svg.addClass('fa-minus')
        console.log(th)

      console.log(predicate)
      console.log($scope.predicate)

      if ($scope.descending)
        angular.element(event.currentTarget).find('svg').addClass('fa-chevron-up')
        angular.element(event.currentTarget).find('svg').removeClass('fa-chevron-down')
        angular.element(event.currentTarget).find('svg').removeClass('fa-minus')
      else
        angular.element(event.currentTarget).find('svg').removeClass('fa-chevron-up')
        angular.element(event.currentTarget).find('svg').addClass('fa-chevron-down')
        angular.element(event.currentTarget).find('svg').removeClass('fa-minus')

      $scope.predicate = predicate
      $scope.descending = !$scope.descending

    if not $scope.getSortIcon
      $scope.getSortIcon = (predicate, currentPredicate, descending) ->
        if predicate != $scope.predicate
          return "minus"
        if descending
          return "chevron-down"
        return "chevron-up"

    @setup.link($scope, $element, $attributes, $filter)
