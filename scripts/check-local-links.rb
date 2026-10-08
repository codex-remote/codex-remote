#!/usr/bin/env ruby

require "pathname"
require "uri"

ROOT = Pathname.new(__dir__).parent.expand_path
MARKDOWN_LINK = /!?(?:\[[^\]]*\])\(([^)\s]+)(?:\s+["'][^"']*["'])?\)/
HTML_IMAGE = /<img\s+[^>]*src=["']([^"']+)["']/i

failures = []

ROOT.glob("**/*.md").sort.each do |document|
  document.read.scan(MARKDOWN_LINK).flatten
    .concat(document.read.scan(HTML_IMAGE).flatten)
    .each do |target|
      next if target.start_with?("#", "http://", "https://", "mailto:")

      path = URI.decode_www_form_component(target.split(/[?#]/, 2).first)
      candidate = document.dirname.join(path).cleanpath
      failures << "#{document.relative_path_from(ROOT)}: missing #{target}" unless candidate.exist?
    end
end

if failures.empty?
  puts "All local Markdown links resolve."
  exit 0
end

warn failures.join("\n")
exit 1
