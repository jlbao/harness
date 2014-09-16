##
# This class encapsulates the history of activities in the
# test harness. It provides the methods for writing to the history
# and gathering the reports from the history.
#
# @author: jbao2@wpi.edu
# @version: 12-Sept-2014
##
require_relative 'test_directory'
require 'fileutils'
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
      hix = "%03d" % history_index
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
  
  
  def read_tests tests
    history = File.open(@current)
    lines = history.readlines
    found_status = []
    lines.each do |line|
        status = eval(line)
        next if status[:tests] == nil
        tests.each do |test|
          if status[:tests].include? test then
              found_status << status
              break
          end
        end
    end
    found_status
  end


  # Read the last lines written to the history and return it as an array of
  # lines (separated by newline characters)
  #
  # @param [Integer] n the number of lines to read, defaults to 10
  # @return [Array] an array of strings
  def read_last n=-1
    history = File.open(@current)
    lines = history.readlines
    if n != -1 then
      lines = lines[-n..-1] if (lines.size > n)
    end
    status_list = Array.new
    lines.each do |line|
        status_list << eval(line)
    end
    return status_list
  end
  
  # Return the results of the last harness run
  def get_last_run
    lines = File.open(@current).readlines
    last_ix = -1
    lines.each_index do |i|
      last_ix = i if lines[i] =~ /^Harness run:/
    end
    if last_ix == -1 then
      return "Harness has not been run"
    end
    lines[last_ix..(lines.size-1)].join("")
  end
  ################################### utility methods #################################
  protected
  def self.create_new_history_file(hist_dir, history_ix)
    history = File.new("#{hist_dir}/current", 'w')
    # hix = "%03d" % history_ix
    # history.puts "History #{hix}"
    # history.puts "Initialized: #{Time.new}"
    history.close
  end
end