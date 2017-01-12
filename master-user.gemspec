# -*- encoding: utf-8 -*-
# stub: master-user 0.2.33 ruby lib

Gem::Specification.new do |s|
  s.name = "master-user"
  s.version = "0.2.34"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["master"]
  s.date = "2015-12-13"
  s.description = ""
  s.email = ["info@themastergolf.com"]
  s.files = ["MIT-LICENSE", "README.rdoc", "Rakefile", "lib/generators", "lib/generators/user", "lib/generators/user/templates", "lib/generators/user/templates/change_user.rb", "lib/generators/user/user_generator.rb", "lib/helpers", "lib/helpers/push_message_helper.rb", "lib/master-user", "lib/master-user.rb", "lib/master-user/version.rb", "lib/models", "lib/models/captcha.rb", "lib/models/complaint.rb", "lib/models/message.rb", "lib/models/message_param.rb", "lib/models/phone_area.rb", "lib/models/token.rb", "lib/models/trade_record.rb", "lib/models/user.rb", "lib/uploaders", "lib/uploaders/base_uploader.rb", "lib/uploaders/user_uploader.rb", "lib/utilities", "lib/utilities/uuid.rb"]
  s.homepage = "http://www.mastergolf.cn"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Master User Center"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 4.0.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 4.0.0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 4.0.0"])
      s.add_runtime_dependency(%q<carrierwave>, [">= 0"])
      s.add_runtime_dependency(%q<carrierwave-imageoptimizer>, [">= 0"])
      s.add_runtime_dependency(%q<rmagick>, [">= 0"])
      s.add_runtime_dependency(%q<aasm>, [">= 0"])
      s.add_runtime_dependency(%q<sunspot_rails>, [">= 0"])
      s.add_runtime_dependency(%q<aliyun-mns>, [">= 0.1.2"])
    else
      s.add_dependency(%q<activerecord>, [">= 4.0.0"])
      s.add_dependency(%q<activesupport>, [">= 4.0.0"])
      s.add_dependency(%q<activemodel>, [">= 4.0.0"])
      s.add_dependency(%q<carrierwave>, [">= 0"])
      s.add_dependency(%q<carrierwave-imageoptimizer>, [">= 0"])
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<aasm>, [">= 0"])
      s.add_dependency(%q<sunspot_rails>, [">= 0"])
      s.add_dependency(%q<aliyun-mns>, [">= 0.1.2"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 4.0.0"])
    s.add_dependency(%q<activesupport>, [">= 4.0.0"])
    s.add_dependency(%q<activemodel>, [">= 4.0.0"])
    s.add_dependency(%q<carrierwave>, [">= 0"])
    s.add_dependency(%q<carrierwave-imageoptimizer>, [">= 0"])
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<aasm>, [">= 0"])
    s.add_dependency(%q<sunspot_rails>, [">= 0"])
    s.add_dependency(%q<aliyun-mns>, [">= 0.1.2"])
  end
end
