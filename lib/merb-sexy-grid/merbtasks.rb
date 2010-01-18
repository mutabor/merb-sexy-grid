require 'fileutils'

namespace :merb_sexy_grid do
  desc "Update assets for sexy grid"
  task :update_assets do
    assets = File.join(File.dirname(__FILE__), "../../assets")
    FileUtils.cp(File.join(assets, "stylesheets/sexy_grid.css"), "public/stylesheets/")
    FileUtils.mkdir_p("public/images/sexy_grid")
    FileUtils.cp(File.join(assets, "images/sexy_grid/fieldbg.gif"), "public/images/sexy_grid/")
  end
end
