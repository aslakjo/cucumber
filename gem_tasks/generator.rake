class Cuke4NukeGenerator
  def generate
    require 'gherkin'
    require 'erb'

    steps_file = File.open("steps.cs", "w")

    steps = generate_steps_for_all_supported_languages
    steps_file.puts steps
    
    steps_file.close
  end

  def generate_steps_for_all_supported_languages
    steps = ""
    Gherkin::I18n.all.each do |lang|
        given_keyword, when_keyword, then_keyword = narative_keywords(lang)

        template = ERB.new(IO.read(File.dirname(__FILE__) + '/i18n_steps.cs.erb'))
        steps += template.result(binding)
        steps += "\n"
    end

    steps
  end

  def narative_keywords(language)
    [language.keywords("given").last, language.keywords("when").last, language.keywords("then").last]
  end
end

desc 'Generate step defs for staticly typed languages'
task :generate do
  Cuke4NukeGenerator.new.generate
end