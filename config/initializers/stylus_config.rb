# setup load paths for stylus includes
Stylus.paths << "#{Rails.root}/app/assets/stylesheets"
Stylus.paths << "#{Rails.root}/app/assets/images"
Stylus.paths << "#{Rails.root}/public"
Stylus.paths << "#{Rails.root}/public/images"

# add nib plugin path
Stylus.plugin_paths << File.dirname(Stylus::Nib.bundled_path)
Stylus.use :nib
