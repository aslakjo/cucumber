

desc 'Generate step defs for staticly typed languages'
task :generate do
  require File.join( "lib", "cucumber", "language_support", "Cuke4NukeGenerator")
  Cuke4NukeGenerator.new.generate
end