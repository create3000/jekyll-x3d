# jekyll-x3d

Adds support for X3D syntax highlighting to Jekyll. This allows developers to easily integrate and display X3D content within their Jekyll-powered websites.

## Usage

Add the following lines to your `Gemfile`:

```ruby
group :jekyll_plugins do
  gem 'jekyll-x3d', '~> 1.0'
end
```

After this, run `bundle install; bundle update`.

In your `_config.yml` you need to specify that you want to use `rouge` as syntax highlighter.

```yml
kramdown:
  syntax_highlighter: rouge
```

Now you can highlight your source code in Markdown as X3D:

``````md
```x3d
<Script DEF='Example'>
<![CDATA[ecmascript:
// foo
function initialize ()
{
   const a = new MFString ("abc");
}
]]>
</Script>
```
``````

## See Also

* [X_ITE X3D Browser](https://create3000.github.io/x_ite/)
* [web3d.org](https://www.web3d.org)
