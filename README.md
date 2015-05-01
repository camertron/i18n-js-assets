## i18n-js-assets

Compile your Javascript translations using the asset pipeline instead of rake tasks.

## Installation

`gem install i18n-js-assets` or put it in your Gemfile:

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

## Authors

* Cameron C. Dutro: http://github.com/camertron
