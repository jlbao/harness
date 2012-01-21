##
# This class encapsulates things we can do on a directory in the test
# harness.
#
# Author: gpollice@cs.wpi.edu
# Version: 20-Jan-2012
##

class TestDirectory
  #
  # Constructor takes the directory path. By default, it is the
  # current path.
  #
  def initialize directory_path = '.'
    @dir_path = "#{directory_path}"
  end
  
  #
  # return the files in this directory.
  #
  def files
    entries = []
    Dir.entries(@dir_path).each do |e|
      entries.push e if File.file? "#{@dir_path}/#{e}"
    end
    entries
  end
  
  #
  # Return the suubdirectories of this directory.
  #
  def subdirectories
    entries = []
    Dir.entries(@dir_path).each do |e|
      entries.push e if File.directory? "#{@dir_path}/#{e}"
    end
    entries - [".", ".."]
  end
  
  #
  # Move a file from one (sub)directory to another, possibly renaming
  # the file in the process.
  #
  def move(file_name, from_sub, to_sub, new_name=nil)
    from_path = "#{@dir_path}/#{from_sub}/#{file_name}"
    new_name = file_name if new_name.nil?
    permissions = File.stat(from_path).mode & 0o777
    to_path = "#{@dir_path}/#{to_sub}/#{new_name}"
    IO.copy_stream(from_path, to_path)
    File.chmod(permissions, to_path)
    File.delete from_path
  end
end