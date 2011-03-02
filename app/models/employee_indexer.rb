class EmployeeIndexer
  # Define all the properties of Employee.rb that we want to index 
  @@keys_to_index = ['first_name', 'last_name', 'job_title', 'industry', 'industry_tags', 'skill_tags', 'product_tags', 'email', 'professional_info', 'give_gets', 'interesting_facts', 'location', 'description' ]
  
  # Defines a property on class that represents our IndexTank's index
  def self.index
     @api ||= IndexTank::Client.new(API_URL)
     @index ||= @api.indexes(INDEX_NAME)
  end

  # Creates the IndexTank index - Not sure this is being used within app as Heroku handles initial creation for us.  
  # I believe for local testing and creation of ad-hoc indexes we'll need this method.
  def self.create_index
    @index.add
    while not @index.running?
      puts 'waiting for index to start'
      sleep 1
    end
  end

  # Facilitates the searching of our index via IndexTank.  The query string passed in will 
  # search all text portion of our documents defined by the aggregation of our @@keys_to_index
  def self.search(query)
    # Searches over __any key 
    #@@keys_to_index.each do |value|
    #  query_to_search << "#{value}:(#{query})"
    #end
    index.search("__any:(#{query.to_s})")
  end

  # Adds the Employee model to our index.  
  # This is called from the after_save filter within our Employee model.
  # This loops over each property within the employee 
  def self.add_document(employee)
    filters = {}
    any = []
    employee.each do |name, value|
      unless !@@keys_to_index.include?(name) 
        value = value.join "," if value.kind_of?(Array)
        if (!value.nil? and !value.empty?)
          filters[name] = value
          any << value
        end
      end
    end
    filters[:__any] = any.join(" . ")
    index.document(employee.id).add(filters)
  end

  # Deletes this index
  def self.delete
    index.delete
  end

end
