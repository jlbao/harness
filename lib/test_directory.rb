##
# This class encapsulates things we can do on a directory in the test
# harness.
#
# @author gpollice@cs.wpi.edu
# @version 20-Jan-2012
##

class TestDirectory
  #
  # Constructor takes the directory path. 
  # @param [String] directory_path by default, it is the current path.
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
  # Rename a file in this directory.
  # @param [String] from_name the original file name
  # @param [String] to_name the new file name
  #
  def rename(from_name, to_name)
    from_path = "#{@dir_path}/#{from_name}"
    to_path = "#{@dir_path}/#{to_name}"
    permissions = File.stat(from_path).mode & 0o777
    IO.copy_stream(from_path, to_path)
    File.chmod(permissions, to_path)
    File.delete from_path
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