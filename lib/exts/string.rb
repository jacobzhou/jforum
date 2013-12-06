class String
  def true?
    self == 'true'
  end

  def false?
    self == 'false'
  end

  def to_en
    Pinyin.t(self, splitter: '')
  end
end