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
          # array of IDs
          ids = parsed_query_string[key]
          # resource class
          resource = key.classify.constantize
          primary_key = resource.primary_key

          # build SQL query
          query = "UPDATE #{resource.table_name} SET #{resource.new.position_column} = CASE\n"

          ids.each_with_index { |id, position|
            query += "WHEN #{primary_key} = #{id} THEN #{position}\n"
          }

          query += "END WHERE #{primary_key} IN (#{ids.join(',')})"

          # execute query
          ActiveRecord::Base.connection.execute(query)

          render json: { success: true }
        end
      end
    end

    module TableMethods
      HANDLE = '&#x2195;'.html_safe

      def sortable_handle_column
        column '' do
          content_tag :span, HANDLE, :class => 'handle', :title => 'Drag to reorder'
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


