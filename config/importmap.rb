# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Action Cable (use CDN since vendor asset missing)
pin "@rails/actioncable", to: "https://cdn.jsdelivr.net/npm/@rails/actioncable@8.1.3/app/assets/javascripts/actioncable.esm.js"
pin "channels", to: "channels/index.js"
