module TableCloth
  module Presenters
    class CellsOnly < Default

      def render_table
        @render_table ||= begin
          o = ''.html_safe
          objects.each {|object| o << row_for_object(object) }
          o
        end
      end

    end
  end
end