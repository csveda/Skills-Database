require 'spec_helper'
require File.join(FIXTURE_PATH, 'base_fixture')
require File.join(FIXTURE_PATH, 'employee_fixture')

describe Employee do

  before(:each) do
    @obj = EmployeeWithDefaultValues.new
  end
  
  
=begin
  
  # TODO: This was an initial test to see how couchrest model was working...can probably be removed or 
  # moved into the base_spec class
  describe "instance database connection" do
      it "should use the default database" do
        @obj.database.name.should == "skillsdb-#{Rails.env}"
      end

      it "should override the default db" do
        @obj.database = CouchServer.database!('couchrest-extendedmodel-test')
        @obj.database.name.should == 'couchrest-extendedmodel-test'
        @obj.database.delete!
      end
  end
  
  # TODO: This was an initial test to see how couchrest model was working...can probably be removed or 
  # moved into the base_spec class
  describe "a new model" do
      it "should be a new document" do
        @obj.rev.should be_nil
        @obj.should be_new
        @obj.should be_new_document
        @obj.should be_new_record
      end

      it "should not failed on a nil value in argument" do
        @obj = EmployeeWithDefaultValues.new(nil)
        @obj.should_not be_nil
      end
    end
    
=end

end

