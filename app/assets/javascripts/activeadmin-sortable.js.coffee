#= require_directory .

$ ->
  $ 'table.index_table tbody'
  .sortable {
    items: 'tr'
    handle: '.handle'
    helper: 'clone'
    update: (event, ui) ->
      query_string = $(@).sortable 'serialize'
      params = $.deparam query_string, true
      resource = Object.keys(params)[0]
      path = 'reorder_admin_' + resource.pluralize() + '_path'

      $.post Routes[path](), {qs: query_string}, (response) ->
        console.log response
    }
    .disableSelection()