module TableCloth
  module Presenters
    class CellsOnly < Default

      def render_table
        @render_table ||= begin
          (objects.map {|object| row_for_object(object) }.join).html_safe
        end
      end

    end
  end
end