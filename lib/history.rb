##
# This class encapsulates the history of activities in the
# test harness. It provides the methods for writing to the history
# and gathering the reports from the history.
#
# @author: gpollice@cs.wpi.edu
# @version: 22-Jan-2012
##
require_relative 'test_directory'
class History
  #
  # Create a new history file and return the new file. The new file
  # will have an index that is 1 greater than the previous. It will
  # be named current. The previous current (if any) will be renamed
  # to historynnn, where nnn is the index.
  # 
  # @param [String, Symbol] harness_dir the test harness's root directory
  #   defaults to '.'
  # @return [History] the new, History object
  #
  def self.start_new_history(harness_dir = '.')
    hist_dir = "#{harness_dir}/history"
    history_index = 0
    if File.exist?("#{harness_dir}/history/current") then
      curdir = History.new harness_dir
      history_index = curdir.index
      hix = "%03" % history_index
      hd = TestDirectory.new hist_dir
      hd.rename("current", "history#{hix}")
    end
    create_new_history_file(hist_dir, history_index + 1)
    return History.new harness_dir
  end
  
  # Constructor
  # @param [String, Symbol] harness_dir the test harness's root directory
  #   defaults to '.'
  def initialize(harness_dir = '.')
    @hist_dir = "#{harness_dir}/history"
    @current = "#{@hist_dir}/current"
    History.create_new_history_file(@hist_dir, 1) if !File.exist?(@current)
  end
  
  # Return the index of the current history
  # @return [Integer] the index of the current history file
  def index
    history = File.open(@current)
    line = history.readline.rstrip
    line =~ /(\d+)$/    # get the index
    $1.to_i
  end
  
  # Write a log message to the history file. This does absolutely no
  # editing or make any assumptions about the message.
  #
  # @param [String] msg the message to be logged. This may be multiple
  #  lines.
  def log msg
    history = File.open(@current, "a")
    history.puts msg
    history.close
  end
  
  # Read the last lines written to the history and return it as an array of
  # lines (separated by newline characters)
  #
  # @param [Integer] n the number of lines to read, defaults to 10
  # @return [Array] an array of strings
  def read_last n=10
    history = File.open(@current)
    lines = history.readlines
    lines = lines[-n..-1] if (lines.size > n)
    return lines
  end
  ################################### utility methods #################################
  protected
  def self.create_new_history_file(hist_dir, history_ix)
    history = File.new("#{hist_dir}/current", 'w')
    hix = "%03d" % history_ix
    history.puts "History #{hix}"
    history.puts "Initialized: #{Time.new}"
    history.close
  end
end