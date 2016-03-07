require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "Richard", email: "richard@example.com", password: "password", admin: true)
  end
  
  
  test 'get new category form and create category' do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test 'invalid category submission results in failure' do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ''}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end