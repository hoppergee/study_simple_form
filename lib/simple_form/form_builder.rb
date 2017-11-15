require 'simple_form/label'

module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    inlcude SimpleForm::Label

    def input(attribute, options={})
      @attribute, @options = attribute, options
      @options.assert_valid_keys(:as, :label, :options, :html)

      label = generate_label
      input = generate_input

      label << input
    end

    private

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
