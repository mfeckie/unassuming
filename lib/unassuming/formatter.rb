require 'rspec/core/formatters/base_text_formatter'
require 'pry'

module RSpec
  module Core
    module Formatters
      class Unassuming < RSpec::Core::Formatters::BaseTextFormatter
        include RSpec::Core::Formatters::ConsoleCodes

        Formatters.register self, :start, :example_passed, :example_failed, :example_pending

        attr_reader :output, :failed_examples

        def initialize(output)
          @output = output
          super(output)
        end

        def start(example_count)
          super(example_count)
          cyan_line
          output.print(bold('Starting Spec Run @ '), green(now), ' -> ')
          @example_results = []
          @failed_examples = []
          @pending_examples = []
        end

        def example_passed(example)
          output.print green('好 ')
        end

        def example_failed(example)
          failed_examples << example
          output.print red('☢')
        end

        def example_pending(example)
          output.print yellow(example)
        end

        def dump_failures(notification)
          return if failed_examples.empty?
          failed_examples.each_with_index do |example, index|
            dump_failure(example, index)
          end
        end

        def dump_failure(example, index)
          output.puts
          dump_failure_info(example, index)
        end

        def dump_failure_info(example, index)
          exception = example.exception
          message = strip_whitespace(exception.message)
          failed_line = strip_whitespace(read_failed_line(example))
          output.print "#{index+1}) #{cyan failed_line}\t #{red message }"
        end

        def dump_summary(run)
          output.puts "\n"
          output.puts "Finished in #{run.duration}\n"
          output.puts "#{run.example_count} examples, #{run.failure_count} failures"
          if run.failure_count > 0
            output.puts bold(red "(╯°□°）╯︵ ┻━┻")
          else
            output.puts bold(magenta "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧")
          end
          cyan_line
        end

        def now
          Time.now.strftime('%H:%M:%S')
        end

        def strip_whitespace(string)
          string.to_s.gsub("\n", ' ').gsub(/\s{2,}/, ' ')
        end

        def cyan_line
          output.puts cyan('--------------------------------------')
        end

        def blue(input)
          wrap(input, :blue)
        end

        def bold(input)
          wrap(input, :bold)
        end

        def cyan(input)
          wrap(input, :cyan)
        end

        def green(input)
          wrap(input, :green)
        end

        def red(input)
          wrap(input, :red)
        end

        def yellow(input)
          wrap(input, :yellow)
        end

        def magenta(input)
          wrap(input, :magenta)
        end

        def read_failed_line(example)
          example.example.location.split("/").last.to_s
        end


      end
    end
  end
end