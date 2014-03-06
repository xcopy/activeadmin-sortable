require 'activeadmin-sortable/version'
require 'activeadmin'
require 'rails/engine'

module ActiveAdmin
  module Sortable
    module ControllerActions
      def sortable
        collection_action :reorder, :method => :post do
          parsed_query_string = Rack::Utils.parse_nested_query(params[:qs])
          key = parsed_query_string.first[0]
          resource = key.classify.constantize

          parsed_query_string[key].each_with_index { |id, position|
            resource.update(id, { position: position })
          }
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


