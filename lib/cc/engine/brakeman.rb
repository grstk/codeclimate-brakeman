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
        {
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
        }.to_json
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
