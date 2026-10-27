cask "melodica" do
  arch arm: "AppleSilicon-arm64", intel: "Intel-x86_64"

  version "1.5.4"
  sha256 arm:   "ВСТАВЬТЕ_SHA256_ДЛЯ_ARM",
         intel: "ВСТАВЬТЕ_SHA256_ДЛЯ_X86"

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
