

desc 'Generate step defs for staticly typed languages'
namespace :generate do
  desc "Steps for cuke4nuke / C#"
  task :cuke4nuke do
    require File.join( "lib", "cucumber", "language_support", "cuke_code_generator")
    CukeCodeGenerator.new("i18n_steps.cs.erb").write_to_file("steps.cs")
  end
end