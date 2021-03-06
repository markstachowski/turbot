class InterestsExtractor
  def initialize(bio:, interests: Interest.all)
    @bio = bio
    @interests = interests
  end

  def perform
    (like_sentences + like_lists).map do |fragment|
      interests.select do |interest|
        interest.matches?(fragment)
      end
    end.flatten.uniq
  end

private

  attr_reader :bio, :interests

  def like_phrases_regex
    '\blikes?|loves?|enjoy|am happiest|am happy|hobbies|passion|i\'?m into|i am into|really into|spare time'
  end

  def like_lists
    matches = bio.scan(
      %r{
        (?:^|[!.])                #start at beginning of line, or sentence
        \s*                       #skip leading whitespace
        [^\n]{0,40}               #allow up to 40 chars of text
        (?:#{like_phrases_regex}) #the like phrase
        [^\n]{0,30}[:-]           #more text then a list indicator char
        \s*                       #ignore whitespace
        (.*?)                     #the actual liked things
        (?:\n\n|\Z)               #stop at a blank link, or end of bio
      }xmi
    )
    if matches.any?
      matches.flatten
    else
      []
    end
  end

  def like_sentences
    @sentences ||= bio.split(/[\n.!]/).select do |s|
      Rails.logger.debug "like_sentences: processing sentence: #{s}"
      #match up to 4 words, then one of the key "like" indication phrases
      s.match(/^(\S*?\s){0,4}(#{like_phrases_regex})/im)
    end
  end
end
