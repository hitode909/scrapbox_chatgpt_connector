require 'cgi'
require 'json'
mt_source = open(ARGV[0]).read

entries = mt_source.split(/\n^--------$\n/)

json_entries = []

entries.each{|entry|
  next unless entry.match(/^STATUS: Publish$/)
  next if entry.match(/^COMMENT:$/)
  sections = entry.split(/^-----$/)
  title = sections[0].scan(/^TITLE: (.*)$/)[0][0]

  body = CGI.unescapeHTML(sections[1].gsub(/^BODY:\n/, '').gsub(/<[^>+]+>/, '').gsub(/\n+/, "\n")).chomp
  json_entries.push({
    title: title,
    lines: body.split(/\n/).map{|line| line.strip }.reject{|line| line.empty? }
  })
}

print JSON.dump({pages: json_entries})

__END__

usage: ruby mt2json.rb ~/Downloads/blog.sushi.money.export.txt > from_hatenablog/blog.sushi.money.json

format example

AUTHOR: xxx
TITLE:
BASENAME: xxx
AUTHOR: xxx
STATUS: Publish
ALLOW COMMENTS: xxx
CONVERT BREAKS: 0
DATE: xxx
-----
BODY:
<p>電気代が高すぎて苦しんでいる。<br />
とりいそぎ、ガスを大阪ガスに戻すことでセット割をやめて従量電灯Aに戻そうと思っている。<br />
１月はオイルヒーターを使っていたのも大きそうで、もう暖かくなってきたのでこんなに電気代上がらないとは思うけど、来年の１
月にまたこれになるのは勘弁してほしいと思う。</p><p><blockquote data-conversation="none" class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">電気代、ガスとまとめたお得プランにしてるのだけど、普通の契約より-18000円お得です！ってメ
ッセージが出てて、普通の契約より割高になってることがわかった。燃料費調整額が上がってくるとこうなるらしい。</p>&mdash; 趣味はマリンスポーツです (@hitode909) <a href="https://twitter.com/hitode909/status/1633678522731618304?ref_src=twsrc%5Etfw">2023年3月9日</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> <blockquote data-conversation="none" class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">メリットなくてす
ごい <a href="https://t.co/qEfA3dXW6X">pic.twitter.com/qEfA3dXW6X</a></p>&mdash; 趣味はマリンスポーツです (@hitode909) <a href="https://twitter.com/hitode909/status/1633693542332919808?ref_src=twsrc%5Etfw">2023年3月9日</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> <blockquote data-conversation="none" class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">全く同じ状況 / “電気料金の燃料費調整額が高い - nakaoka3のなんでもブログ” <a href="https://t.co/YU0b4bT6BU">https://t.co/YU0b4bT6BU</a></p>&mdash; 趣味はマリンスポーツです (@hitode909) <a href="https://twitter.com/hitode909/status/1633691631475113986?ref_src=twsrc%5Etfw">2023年3月9日</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> </p>

-----
--------