require 'activeadmin-sortable/version'
require 'activeadmin'
require 'rails/engine'

module ActiveAdmin
  module Sortable
    module ControllerActions
      def sortable
        collection_action :reorder, :method => :post do
          # parse query string
          parsed_query_string = Rack::Utils.parse_nested_query(params[:qs])

          # get first element of the hash (aka resource singular name)
          key = parsed_query_string.first[0]

          # classify constantize resource name
          resource = key.classify.constantize

          positions = Hash.new

          # update positions
          parsed_query_string[key].each_with_index { |id, position|
            resource.update(id, { position: position })
            positions[position] = id
          }

          # todo
          # render reordered positions
          render json: positions
        end
      end
    end

    module TableMethods
      HANDLE = '&#x2195;'.html_safe

      def sortable_handle_column
        column '' do
          content_tag :span, HANDLE, :class => 'handle'
        end
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

    class Engine < ::Rails::Engine
      # Including an Engine tells Rails that this gem contains assets
    end
  end
end


