Pod::Spec.new do |s|

# 项目名称
s.name         = "WKJBadge"

# 版本号 与 仓库的 标签号 对应
s.version      = "1.0.0"

# 开源证书
s.license      = { :type => "MIT", :file => "LICENSE" }

# 项目简介
s.summary      = "A view badge easy to use"

# 项目主页
s.homepage     = "https://github.com/Jerry-Zed/WKJBadge"

# 仓库地址
s.source       = { :git => "https://github.com/Jerry-Zed/WKJBadge.git", :tag => "#{s.version}" }

# 你代码的位置 WKJBadge/*.{h,m} 表示 WKJBadge 文件夹下所有的.h和.m文件
s.source_files = "WKJBadge/*.{h,m}"

# 是否启用ARC
s.requires_arc = true

# 平台及支持的最低版本
s.platform     = :ios, "8.0"

# 支持的框架
s.frameworks   = "UIKit", "Foundation"

# 依赖库
# s.dependency = ""

# 个人信息
s.author             = { "WKJ" => "843377736@qq.com" } # 作者信息
s.social_media_url   = "https://www.wkjstudio.com" # 个人主页

end
