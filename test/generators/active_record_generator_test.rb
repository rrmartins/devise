require File.expand_path("../generators_test_helper", __FILE__)

if DEVISE_ORM == :active_record
  class ActiveRecordGeneratorTest < Rails::Generators::TestCase
    tests ActiveRecord::Generators::DeviseGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination
  
    test "all files are properly created" do
      run_generator %w(monster)
      assert_file "app/models/monster.rb", /devise/, /attr_accessible (:[a-z_]+(, )?)+/
      assert_migration "db/migrate/devise_create_monsters.rb"
    end
  
    test "all files are properly deleted" do
      run_generator %w(monster)
      run_generator %w(monster), :behavior => :revoke
      assert_no_file "app/models/monster.rb"
      assert_no_migration "db/migrate/devise_create_monsters.rb"
    end
  end
end