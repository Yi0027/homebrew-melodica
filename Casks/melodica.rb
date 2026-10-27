cask "melodica" do
  arch arm: "AppleSilicon-arm64", intel: "Intel-x86_64"

  version "1.5.4"
  sha256 arm:   "40ff5357512abbf68f60f9d492c59087b784f55e97ca7c21e5aa4ef02277bb52",
         intel: "3fb2ddcbb3e3b0d0ee81ac65b52c237090792af23c238b03269d3502e9ea3a81"

  url "https://github.com/Yi0027/Melodica/releases/download/v#{version}/Melodica-#{version}-#{arch}.dmg"
  name "Melodica"
  desc "Audio player for macOS with two themes and advanced LRC support"
  homepage "https://github.com/Yi0027/Melodica"

  livecheck do
    url :url
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]
        next if release["prerelease"] && !version.to_s.include?("-pre")
        match = release["tag_name"]&.match(regex)
        next unless match
        match[1]
      end
    end
  end

  app "Melodica.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Melodica.app"], must_succeed: false
  end
end
