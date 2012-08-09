# -*- encoding: utf-8 -*-
require 'uuid'
module Seeding
  
  class CreateSeed
    # Pass in Activerecord query like Seedy::CreateSeed.new.query {User.where(demo_flag = true)}
    def query(q={})
      @seedy_result = yield
      create @seedy_result
    end

    def create(query_results)
      klass = query_results[0].class.name
      # Create a uuid for the filename so it can't overwrite anything accidentially
      uuid = UUID.new.generate
      File.open("seeding-#{klass}-" + uuid + ".rb" , 'w') do |file|
        file.puts "# -*- encoding: utf-8 -*" 
        query_results.each_with_index.map do |v|
          attrib = v.attributes.keys
          str = "#{klass}.create! "
          attrib.each do |at|
            if v[at].class.to_s == "Fixnum"
              str << " :#{at} => #{v[at]}, "
            else
              str << " :#{at} => '#{v[at]}', "
            end
          end
          str << "**"
          str.gsub!(", **", "")
          str << "\n"
          file.puts str
          file.puts "puts \".\""
        end
      end
    end
  end

end



