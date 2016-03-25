DATA_DIR = './nuc'

filenames = Dir::entries(DATA_DIR)
filenames.shift(2)

results = []

filenames.each do |filename|
  filename = File.join(DATA_DIR, filename)

  begin
    datas = File.read(filename, encoding: 'EUC-JP:UTF-8').split("\r\n")
  rescue Encoding::InvalidByteSequenceError
    datas = File.read(filename, encoding: 'SHIFT_JIS:UTF-8').split("\r\n")
  end

  buffer = {type: nil, comment: ''}

  datas.each do |data|
    next if data[0] == '＠' || data[0] == '％' # コメントアウトを除外

    type, comment = data.split('：')

    if comment
      results.push(buffer) if buffer[:comment] != ''

      buffer = {type: type[0], comment: ''}
    else
      next unless buffer[:comment]             # 先頭部分の説明の除外
      comment = data
    end

    comment.gsub!(/^[\s　]+|[\s　]+$/, "") # strip whitspace
    buffer[:comment] += comment
  end

  results.push(buffer) if buffer[:comment] != ''
end

results.each do |result|
  puts result[:comment]
end
