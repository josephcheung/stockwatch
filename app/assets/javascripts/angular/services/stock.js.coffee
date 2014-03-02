app.factory "Stock", [
  "$resource"
  ($resource) ->
    Stock = ->
      @service = $resource("/api/stocks/:stockId",
        stockId: "@id"
      )
      return
      
    Stock::all = ->
      @service.query()

    Stock::delete = (stId) ->
      @service.remove {stockId: stId}

    Stock::create = (attr) ->
      @service.save attr
    return new Stock
]