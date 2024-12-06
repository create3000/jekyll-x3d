# coding: utf-8
# frozen_string_literal: true
require_relative "lib/jekyll-x3d/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-x3d"
  spec.version = JekyllX3D::VERSION
  spec.authors = ["Holger Seelig"]
  spec.email = ["holger.seelig@gmail.com"]

  spec.summary = "X3D Syntax Highlighter"
  spec.description = "Adds support for X3D syntax highlighting to Jekyll. This allows developers to easily integrate and display X3D content within their Jekyll-powered websites."
  spec.homepage = "https://github.com/create3000/jekyll-x3d/blob/main/README.md"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/create3000/jekyll-x3d/"
  # spec.metadata["changelog_uri"] = "https://github.com/create3000/jekyll-x3d/commits/main/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
