require "brakeman"
require "json"

module CC
  module Engine
    class Brakeman
      def initialize(directory:, io:, engine_config:)
        @directory = directory
        @engine_config = engine_config
        @io = io
      end

      def run
        brakeman = ::Brakeman.run(
          app_path: @directory,
          config_file: "#{@directory}/config/brakeman.yml",
          skip_files: @engine_config["exclude_paths"]
        )

        brakeman.checks.all_warnings.each do |warning|
          @io.print "#{issue_json(warning)}\0"
        end
      end

      private

      def issue_json(warning)
        issue_hash = {
          type: "Issue",
          check_name: warning.check.gsub(/::Check/, "/"),
          description: warning.message,
          categories: ["Security"],
          remediation_points: 50_000,
          location: {
            path: local_path(warning.file),
            lines: {
              begin: warning.line,
              end: warning.line
            }
          }
        }
        unless warning.link.nil?
          issue_hash.merge!(content: { body: content_body(warning.link) })
        end
        issue_hash.to_json
      end

      def content_body(link)
        %r{http://brakemanscanner.org/docs/warning_types/(?<content_name>[^/]+)} =~ link
        path = File.expand_path("../../../../config/contents/#{content_name}.md", __FILE__)
        return File.read(path) if File.exist?(path)
        "Read more: #{link}"
      end

      def local_path(file)
        file.gsub(%r{^#{directory_path}/}, "")
      end

      def directory_path
        @directory_path ||= Pathname.new(@directory).realpath.to_s
      end
    end
  end
end
