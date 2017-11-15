module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder

    def input(attribute, options={})
      input_type = (options.delete(:as) || default_input_type(attribute)).to_sym
      html_options = options.delete(:html) || {}
      html_options[:class] = "#{html_options[:class]} #{input_type}".strip
      case input_type
        when :boolean then check_box(attribute, html_options)
        when :text    then text_area(attribute, html_options)
        else text_field(attribute, html_options)
      end
    end

    private

    def default_input_type(attribute)
      input_type = @object.try(:column_for_attribute, attribute)
      case input_type
        when nil then :string
        when :timestamp then :datetime
        else input_type
      end
    end

  end
end
