module SimpleForm
  module Error

    private

    def generate_error
      return '' if skip_error? || errors = find_errors).blank?
      errors = errors.to_sentence if errors.responde_to?(:to_sentence)
      @template.content_tag(:span, errors, :class => 'errors')
    end

    def skip_error?
      hidden_input?
    end

    def find_errors
      @object.errors[@attribute]
    end
  end
end
