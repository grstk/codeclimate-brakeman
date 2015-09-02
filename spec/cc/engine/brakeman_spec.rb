require "spec_helper"
require "cc/engine/brakeman"
require "tmpdir"

module CC
  module Engine
    describe Brakeman do
      before do
        @code = Dir.mktmpdir
        FileUtils.mkdir_p(File.join(@code, "app/models"))

        create_source_file("app/models/model.rb", <<-EORUBY)
          class Model < ActiveRecord::Base
            attr_accessible :admin
          end
        EORUBY
      end

      describe "#run" do
        it "analyzes Rails app using Brakeman and outputs issues in proper format" do
          results = {
            type: "Issue",
            check_name: "Brakeman/ModelAttrAccessible",
            description: "Potentially dangerous attribute available for mass assignment",
            categories: ["Security"],
            remediation_points: 50_000,
            location: {
              path: File.join(@code, "app/models/model.rb"),
              lines: {
                begin: nil,
                end: nil
              }
            }
          }.to_json

          output = run_engine

          assert output.include?(results)
        end

        it "uses exclusions passed in via the config hash" do
          config = { "exclude_paths" => ["app/models/model.rb"] }

          output = run_engine(config)
          assert !output.include?("ModelAttrAccessible")
        end

        def create_source_file(path, content)
          File.write(File.join(@code, path), content)
        end

        def run_engine(config = nil)
          io = StringIO.new

          engine = Brakeman.new(directory: @code, engine_config: config, io: io)
          engine.run

          io.string
        end
      end
    end
  end
end
