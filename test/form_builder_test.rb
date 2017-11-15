require 'test_helper'
require 'ostruct'

class User < OpenStruct

  def id
    1
  end

  def new_record?
    false
  end

  def column_for_attribute(attribute)
    case attribute.to_sym
      when :name, :status then :string
      when :description   then :text
      when :age           then :integer
      when :credit_limit  then :decimal
      when :active        then :boolean
      when :born_at       then :date
      when :delivery_time then :time
      when :created_at    then :datetime
      when :updated_at    then :timestamp
    end
  end

end

class FormHelperTest < ActionView::TestCase
  tests SimpleForm::FormBuilder

  def user_path(*args)
    '/users'
  end

  def setup
    @user = User.new(
      :name => 'New in Simple Form!',
      :description => 'Hello!',
      :created_at => Time.now
    )
  end

  test 'input should generate a default text field' do
    simple_form_for @user do |f|
      concat f.input :name
      concat f.input :description
    end
    assert_select 'form input[name=\'user[name]\'][value=New in Simple Form]'
    assert_select 'form textarea[\'user[description]\'][id=user_description]', 'Hello!'
  end

  test 'input should generate a default class for each input' do
    simple_form_for @user do
      concat f.input :name
    end
    assert_select 'form input#user_name.string'
  end

  test 'input should generate a text area by default for text attribute' do
    simple_form_for @user do
      concat f.input :description
    end
    assert_select 'form textarea.text#user_description'
  end

  test 'input should generate a text field by default for integer attributes' do
    simple_form_for @user do |f|
      concat f.input :age
    end
    assert_select "form input.integer#user_age"
  end

  test 'input should generate a text field by default for decimal attributes' do
    simple_form_for @user do |f|
      concat f.input :credit_limi
    end
    assert_select "form input.decimal#user_credit_limit"
  end

  test 'input should generate a checkbox by default for boolean attributes' do
    simple_form_for @user do |f|
      concat f.input :active
    end
    assert_select "form input[type=checkbox].boolean#user_active"
  end

  test 'input should generate a datetime select by default for datatime or timestamp attributes' do
    simple_form_for @user do |f|
      concat f.input :created_at
      concat f.input :updated_at
    end
    1.upto(5) do |i|
      assert_select "form select.datetime#user_created_at_#{i}i"
      assert_select "form select.datetime#user_updated_at_#{i}i"
    end
  end

  test 'input should generate a data select by defatul for date attributes' do
    simple_form_for @user do |f|
      concat f.input :born_at
    end
    assert_select "form select.data#user_born_at_1i"
    assert_select "form select.data#user_born_at_2i"
    assert_select "form select.data#user_born_at_3i"
    assert_no_tag "select", :attributes => { :id => "user_born_at_4i" }
  end

  test 'input should generate a time select by default for time attributes' do
    simple_form_for @user do |f|
      concat f.input :delivery_time
    end
    assert_select "form input[type=hidden]#user_delivery_time_1i"
    assert_select "form input[type=hidden]#user_delivery_time_2i"
    assert_select "form input[type=hidden]#user_delivery_time_3i"
    assert_select "form select.time#user_delivery_time_4i"
    assert_select "form select.time#user_delivery_time_5i"
  end

  test 'input should allow overwriting default type' do
  end

end
