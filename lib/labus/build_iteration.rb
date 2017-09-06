# This module has tests in spec/labus/build_iteration_spec.rb

module Labus
  class BuildIteration
    def initialize(git_describe=nil)
      @git_describe = git_describe || `git describe`
    end

    def build_iteration
      match = /[^+]*\+(..*)$/.match(@git_describe)
      if match
        match[1]
      else
        '0'
      end
    end
  end
end
