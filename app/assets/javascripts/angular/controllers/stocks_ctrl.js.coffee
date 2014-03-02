app.controller('StocksCtrl', ['$scope', 'Stock', '$filter', '$http', ($scope, Stock, $filter, $http) ->
  $scope.stocks = Stock.all()

  $scope.createStock = ->
    attr = {}
    attr.symbol = $filter('uppercase')($scope.newSymbol)
    $http({method: 'GET', url: "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20WHERE%20symbol%3D" + "'" + attr.symbol + "'" + "&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"}).success((data, status, headers, config)->
      $scope.error = false
      attr.name = data.query.results.quote["Name"]
      attr.bid = data.query.results.quote["Bid"]
      attr.ask = data.query.results.quote["Ask"]
      attr.year_low = data.query.results.quote["YearLow"]
      attr.year_high = data.query.results.quote["YearHigh"]
      newStock = Stock.create(attr)
      $scope.stocks.push(newStock)
      $scope.newSymbol = ""
      ).error((data, status, headers, config)->
        $scope.error = true
      )
      
  $scope.deleteStock = (id, idx) ->
    $scope.stocks.splice(idx, 1)
    Stock.delete id
  ])