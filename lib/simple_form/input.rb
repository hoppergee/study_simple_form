module SimpleForm
  module Input

    private

    def generate_input
      html_otpions = @opitons[:html] || {}
      html_options[:class] = "#{html_options[:class]} #{@input_type} #{required_class}".strip
      @options[:options]

      input_filed case @input_type
        when :boolean
          check_box(@attribute, html_options)
        when :text
          text_area(@attribute, html_options)
        when :datetime
          date_select(@attribute, @options[:options], html_options)
        when :hidden
          hidden_field(@attribute, html_options)
        else text_field(@attribute, html_options)
      end
    end




  end
end
