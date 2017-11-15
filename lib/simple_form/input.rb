module SimpleForm
  module Input

    private

    def generate_input
      html_otpions = @opitons[:html] || {}
      html_options[:class] = "#{html_options[:class]} #{@input_type} #{required_class}".strip
      html_options[:class] = default_css_classes(html_options[:class])
      @options[:options]

      input_filed case @input_type
        when :boolean
          check_box(@attribute, html_options)
        when :radio
          boolean_collection.inject('') do |result, (text, value)|
            result << radio_button(@attribute, value, html_options) <<
                      label("#{@attribute}_#{value}", text, :class => default_css_classes)
          end
        when :text
          text_area(@attribute, html_options)
        when :datetime
          date_select(@attribute, @options[:options], html_options)
        when :hidden
          hidden_field(@attribute, html_options)
        else text_field(@attribute, html_options)
      end
    end

    def boolean_collection
      [['Yes', true],['No', false]]
    end

  end
end
