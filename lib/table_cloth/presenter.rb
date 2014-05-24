module TableCloth
  class Presenter
    attr_reader :view_context, :objects, :table, :render_options

    def initialize(objects, table, view, render_options={})
      @objects = objects
      @view_context = view
      @table = table.new(objects, view)
      @render_options = render_options
    end

    def render_table
      raise NoMethodError, "You must override the .render_table method"
    end

    def thead
      raise NoMethodError, "You must override the .thead method"
    end

    def tbody
      raise NoMethodError, "You must override the .tbody method"
    end

    def columns
      @columns ||= table.class.columns.map do |name, column_hash|
        column = column_hash[:class].new(name, column_hash[:options])
        ColumnJury.new(column, table).available? ? column : nil
      end.compact
    end

    def row_values(object)
      columns.each_with_object([]) do |column, values|
        values << column.value(object, view_context, table)
      end
    end

    def rows
      objects.each_with_object([]) do |object, row|
        row << row_values(object)
      end
    end

    private

    def tag_options(type, options={})
      options = options.dup

      if TableCloth.config.respond_to?(type)
        options = table.config.config_for(type).merge(options)
        options = TableCloth.config.config_for(type).merge(options)
      end

      options
    end

    def v
      view_context
    end

    def params
      v.params
    end
  end
end