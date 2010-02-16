class CukeCodeGenerator
  
  def initialize(erb_file)
    require 'gherkin'
    require 'erb'
    
    @keywords = []
    @erb_file = erb_file
  end

  def generate
    generate_steps_for_all_supported_languages
  end

  def write_to_file(file)
    steps_file = File.open(file, "w")

    steps = generate()

    steps_file.puts steps
    steps_file.close
  end

  def generate_steps_for_all_supported_languages
    steps = ""
    Gherkin::I18n.all.each do |lang|
        given_keyword, when_keyword, then_keyword= narative_keywords(lang)
        language = lang.keywords("grammar_name").first
        strip_keyword_of_paranteses! language
        @keywords << [language, given_keyword, when_keyword, then_keyword]

        template = ERB.new(IO.read(File.dirname(__FILE__) + '/' + @erb_file))
        steps += template.result(binding)
        steps += "\n"
    end

    steps
  end

  def keywords
    @keywords
  end

  def narative_keywords(language)
    remove_duplication_in_keywords [fetch_keyword_for(language, "given"), fetch_keyword_for(language, "when"), fetch_keyword_for(language, "then")]
  end

  private
  def remove_duplication_in_keywords(keywords)
    uniqe_keywords = []
    keywords.each do |keyword|
      unless uniqe_keywords.include? keyword
        uniqe_keywords.push keyword
      else
        uniqe_keywords.push nil
      end
    end
    uniqe_keywords
  end


  def fetch_keyword_for(language, keyword)
    translated_keyword = language.keywords(keyword).last
    strip_illegal_characters! translated_keyword
    
    if contains_standard_keyword? translated_keyword 
      nil
    else
      translated_keyword
    end
  end

  def contains_standard_keyword?(i18n_keyword)
    standard_keywords = ["given", "when", "then"]

    standard_keywords.each do |keyword|
      if keyword =~ /^#{i18n_keyword}$/i
        return true
      end
    end

    false
  end

  def strip_illegal_characters!(keyword)
    keyword.gsub!(/[<>\s']/, "")
  end

  def strip_keyword_of_paranteses!(language)
    language.gsub!(/[\)\(]/, "")
  end
end