module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder

    def input(attribute, options={})
      @attribute, @options = attribute, options

      label = generate_label
      input = generate_input

      label << input
    end

    private

    def generate_label
      return '' if @options[:label] == false
      unless label_text = @options[:label]
        default = @object.try(:human_attribute_name, @attribute.to_s) || @attribute.to_s.humanize
        options[:label] ||= I18n.t("views.labels.#{@object_name}.#{@attributes}", default: default)
      end
      label(@attribute, label_text)
    end

    def generate_input
      input_type = (@options[:as] || default_input_type).to_sym
      html_options = @options.delete(:html) || {}
      html_options[:class] = "#{html_options[:class]} #{input_type}".strip
      @options[:options]

      input_filed case input_type
        when :boolean
          check_box(@attribute, html_options)
        when :text
          text_area(@attribute, html_options)
        when :datetime
          date_select(@attribute, @options[:options], html_options)
        else text_field(@attribute, html_options)
      end
    end

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
