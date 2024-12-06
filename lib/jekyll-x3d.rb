# -*- coding: utf-8 -*- #
# frozen_string_literal: true

require_relative "jekyll-x3d/version"
require "jekyll"

# This "hook" is executed right before the site"s pages are rendered
Jekyll::Hooks.register :site, :pre_render do |site|
  # puts "Adding X3D Markdown Lexer ..."
  require "rouge"

  # This class defines the X3D lexer which is used to highlight "x3d" code snippets during render-time
  class X3D < Rouge::RegexLexer
    title "X3D"
    desc "X3D XML Encoding"

    tag "x3d"
    filenames "*.x3d"

    mimetypes "model/x3d+xml"

    def self.detect?(text)
      return true if text.doctype?(/X3D/)
      return true if text =~ /<X3D\b/
    end

    start do
      @javascript = Rouge::Lexers::Javascript.new(options)
      @glsl = Rouge::Lexers::Glsl.new(options)
    end

    state :root do
      rule %r/[^<&]+/, Text
      rule %r/&\S*?;/, Name::Entity

      rule %r/(<!\[CDATA\[)((?:ecmascript|javascript|vrmlscript):|data:(?:text|application)\/javascript,)/ do
        groups Comment::Preproc, Str::Delimiter
        @javascript.reset!
        push :ecmascript
      end

      rule %r/(<!\[CDATA\[)(data:x-shader\/(?:x-fragment|x-vertex),)/ do
        groups Comment::Preproc, Str::Delimiter
        @glsl.reset!
        push :glsl
      end

      rule %r/<!\[CDATA\[.*?\]\]\>/, Comment::Preproc
      rule %r/<!--/, Comment, :comment
      rule %r/<\?.*?\?>/, Comment::Preproc
      rule %r/<![^>]*>/, Comment::Preproc

      # open tags
      rule %r(<\s*[\p{L}:_][\p{Word}\p{Cf}:.·-]*)m, Name::Tag, :tag

      # self-closing tags
      rule %r(<\s*/\s*[\p{L}:_][\p{Word}\p{Cf}:.·-]*\s*>)m, Name::Tag
    end

    state :comment do
      rule %r/[^-]+/m, Comment
      rule %r/-->/, Comment, :pop!
      rule %r/-/, Comment
    end

    state :tag do
      rule %r/\s+/m, Text
      rule %r/[\p{L}:_][\p{Word}\p{Cf}:.·-]*\s*=/m, Name::Attribute, :attr
      rule %r(/?\s*>), Name::Tag, :pop!
    end

    state :attr do
      rule %r/\s+/m, Text
      rule %r/".*?"|'.*?'|[^\s>]+/m, Str, :pop!
    end

    state :ecmascript do
      rule %r/[^\]]+/ do
        delegate @javascript
      end

      rule %r/\]\]\>/, Comment::Preproc, :pop!

      rule %r/\]/ do
        delegate @javascript
      end
    end

    state :glsl do
      rule %r/[^\]]+/ do
        delegate @glsl
      end

      rule %r/\]\]\>/, Comment::Preproc, :pop!

      rule %r/\]/ do
        delegate @glsl
      end
    end
  end
end
