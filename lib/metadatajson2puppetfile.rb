require "metadatajson2puppetfile/version"

module Metadatajson2puppetfile
  METADATA = "metadata.json"
  def self.run
    if File.exists?(METADATA)
      begin
        data = JSON.parse(File.readlines(filename))
        data["dependencies"].each { |dep|
          if dep["version_requirement"] =~ /\d+\.\d+\.\d+/
            version_string = dep["version_requirement"]
          else
            version_string = ":latest"
          end
          dep_string = "mod '#{dep['name']}', '#{version_string}'"
          puts dep_string
        }
        puts "done"
      rescue JSON::ParserError
        raise "syntax error in #{METADATA}"
      end

    else
      abort("#{METADATA} not found in current directory")
    end
  end
end
