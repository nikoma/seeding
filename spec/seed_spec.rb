require 'spec_helper'
require "active_record"
require 'uuid'
require 'rake'
require 'employee'

describe Seeding::CreateSeed, "create" do
  before(:each) do
    @instance = Seeding::CreateSeed.new
    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database  => File.dirname(__FILE__) + "/testdb.sqlite3"
    )
    
  end
  
  it "should generate proper row values for a given model" do
    # step 0 : Clean up
    Dir.glob("seeding-*.rb") do |fname|
      File.delete fname
    end
    
    Employee.delete_all
    
    # step 1 : create an instance of the model
    test_model = Employee.new
    
    # step 2 : Generate random values
    temp_name = UUID.new.generate
    temp_name = temp_name + "tes\"t1"
    temp_name = temp_name + "tes't2"
    
    # step 3 : insert values into the model
    test_model.name = temp_name
    test_model.save
    
    # step 4 : generate seed file
    Seeding::CreateSeed.new.query { Employee.all}
    Dir.glob("seeding-*.rb") do |fname|
      @seedfile = fname
    end
    
    # step 5 : delete values from the model
    Employee.delete_all
    
    # step 6 : execute seed file
    fileContent = File.open(@seedfile, "r").read
    fileContent.gsub!(/\r\n?/, "\n")
    fileContent.each_line do |row|
      eval "#{row}"
    end
    
    # Step 7 : Delete seed file
    Dir.glob("seeding-*.rb") do |fname|
      File.delete fname
    end
    
    # step 8 : read model and compare with initial values
    test_model = Employee.find(:all).first
    
    # Step 9 : compare the result from step 8 and it should match 
    test_model.name.should eq temp_name
  end
end
