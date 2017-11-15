module SimpleForm
  module Label

    private

    def generate_label
      return '' if @options[:label] == false
      html_options = { :class => "#{@input_type} #{required_class}" }
      label(@attribute, @options[:label] || translate_label, html_options)
    end

    def translate_label
      default = @object.try(:human_attribute_name, @attribute.to_s) || @attribute.to_s.humanize
      options[:label] ||= I18n.t("views.labels.#{@object_name}.#{@attributes}", default: default)
    end
  end
end
