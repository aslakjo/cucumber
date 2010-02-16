

desc 'Generate step defs for staticly typed languages'
namespace :generate do
  desc "Steps for cuke4nuke / C#"
  task :cuke4nuke do
    require File.join( "lib", "cucumber", "language_support", "Cuke4NukeGenerator")
    Cuke4NukeGenerator.new.generate
  end
end