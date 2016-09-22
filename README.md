[![Build Status](https://travis-ci.org/camertron/i18n-js-assets.svg)](https://travis-ci.org/camertron/i18n-js-assets)

## i18n-js-assets

Compile your Javascript translations using the asset pipeline instead of rake tasks.

## Installation

`gem install i18n-js-assets`

or put it in your Gemfile:

```ruby
gem 'i18n-js-assets'
```

This gem is designed to work with Rails. Adding it to your Gemfile should be enough to add it to your project - you shouldn't need to manually require it.

### What Dis?

The [i18n-js gem](https://github.com/fnando/i18n-js) brings your Rails translations (eg. config/locales/en.yml) the land of Javascript. Just add a config file, run a rake task, and your translations are now available in Javascript. Wouldn't it be cool if your js translations could be automatically compiled by the Rails asset pipeline instead? That's where i18n-js-assets can help. Instead of creating a single config file, you'll put smaller bits of config into individual files with an `.i18njs` extension. i18n-js-assets adds a custom processor to the asset pipeline to render the right translations in each file.

### Getting Started

Let's say you have an i18n-js config at `config/i18n-js.yml` that looks like this:

```yaml
translations:
  - file: "app/assets/javascripts/i18n/translations.js"
  - file: "engines/my_engine/app/assets/javascripts/i18n/translations.js"
    only: - '*.my_engine.*'
```

Break this file up into two separate files:

Here's `app/assets/javascripts/i18n/translations.js.i18njs`:

```yaml
---
```

And here's `engines/my_engine/app/assets/javascripts/i18n/translations.js.i18njs`

```yaml
only: - '*.my_engine.*'
```

Require these files as you normally would. For example in your app's main `application.js`:

```
//= require i18n/translations
```

Voilà! The translations should now be available in your Javascript code just as if you'd used i18n-js and its rake tasks.

### Additional Options

In addition to the `only` and `except` options that i18n-js provides, you can also specify an array of locales in each .i18njs file. Only the translations from these locales will be included. If the locale list isn't specified, i18n-js-assets will include the translations for every locale.

```yaml
only: - '*.my_engine.*'
locales:
  - en
  - es
  - pt
  - ko
```

### Asset Precompilation

Any .i18njs file can be added to your application's asset precompile list just as you might do with any other type of asset. However, it can be inefficient to include the translations for every language in your Javascript bundle, especially if you have lots of translations. To avoid this, i18n-js-assets supports splitting translations up into individual files, one per locale, for precompilation. Try something like this in your config/application.rb:

```ruby
config.assets.localized.add(
  'i18n/translations.js',
  'i18n/translations-%{locale}.js',
  { precompile: I18n.available_locales }
)
```

Notice the special `%{locale}` interpolation placeholder. Now when assets are precompiled, you should see one file per locale in the `i18n` directory, eg: `i18n/translations-en.js`, `i18n/translations-es.js`, `i18n/translations-ko.js`, etc. Note that the `precompile` option shown above can also be a proc or lambda that returns an array of locale strings. Note also that the list of locales specified by the `precompile` option takes precedence over the `locales` list in any source .i18njs file.

## Requirements

Your Rails app needs to be using i18n-js v3.0.0 (currently release candidate 14).

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
