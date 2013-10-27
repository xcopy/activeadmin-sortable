ActiveAdmin.register Thing do
  
  config.sort_order = 'position_asc'
  config.paginate   = false

  sortable

  index do
    sortable_handle_column
    column :position
    column :name
  end

end
