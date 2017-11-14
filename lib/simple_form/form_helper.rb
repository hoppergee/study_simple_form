module SimpleForm
  module FormHelper

    def simple_form_for(*args, &block)
      options = args.extract_options!
      options[:builder] = SimpleForm::FormBuilder
      fomr_for(*(args << options), &block)
    end

  end
end
