#= require_tree ./lib

$ ->
  $ 'table.index_table tbody'
  .sortable {
    items: 'tr'
    handle: '.handle'
    helper: (event, ui) ->
      cells = ui.children();
      row = ui.clone();
      row.children().each (i) ->
        $(@).width cells.eq(i).width()
      row
    update: (event, ui) ->
      $this = $(@)
      query_string = $this.sortable 'serialize'
      params = $.deparam query_string, true
      resource = Object.keys(params)[0]
      path = 'reorder_admin_' + resource.pluralize() + '_path'

      $.post Routes[path](), {qs: query_string}, (response) ->
        $this.children 'tr'
        .each (i, row) ->
            $(row)
            .removeClass 'odd even'
              .addClass if i%2 then 'even' else 'odd'
    }
    .disableSelection()