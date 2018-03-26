component "rubygem-puppet-resource_api" do |pkg, settings, platform|
  pkg.version "1.0.1"
  pkg.md5sum "d0137df09119ffb130d5baf1ffda1f9f"
  pkg.url "https://rubygems.org/downloads/puppet-resource_api-#{pkg.get_version}.gem"
  pkg.mirror "#{settings[:buildsources_url]}/puppet-resource_api-#{pkg.get_version}.gem"

  pkg.build_requires "ruby-#{settings[:ruby_version]}"

  # When cross-compiling, we can't use the rubygems we just built.
  # Instead we use the host gem installation and override GEM_HOME. Yay?
  pkg.environment "GEM_HOME", settings[:gem_home]

  # PA-25 in order to install gems in a cross-compiled environment we need to
  # set RUBYLIB to include puppet and hiera, so that their gemspecs can resolve
  # hiera/version and puppet/version requires. Without this the gem install
  # will fail by blowing out the stack.
  pkg.environment "RUBYLIB", "#{settings[:ruby_vendordir]}:$(RUBYLIB)"

  pkg.install do
    ["#{settings[:gem_install]} puppet-resource_api-#{pkg.get_version}.gem"]
  end
end
