require "metadatajson2puppetfile/version"

module Metadatajson2puppetfile
  METADATA = "metadata.json"
  def self.run
    if File.exists?(METADATA)
      begin
        data = JSON.parse(File.read(METADATA))
        puts "# dependences for #{data['name']}"
        data["dependencies"].each { |pair|
          if pair["version_requirement"] =~ /^\d+\.\d+\.\d+$/
            version_string = pair["version_requirement"]
          else
            version_string = ":latest"
          end
          dep_string = "mod '#{pair['name']}', '#{version_string}'"
          puts dep_string
        }
      rescue JSON::ParserError
        raise "syntax error in #{METADATA}"
      end

    else
      abort("#{METADATA} not found in current directory")
    end
  end
end
