cask "melodica" do
  version "1.4.3-pre"
  sha256 "431cf21b67424d213e24343811f2a95f755dcc286961e035e9b76430765e9723"

  url "https://github.com/Yi0027/Melodica/releases/download/v#{version}/Melodica.dmg"
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
    run "/usr/bin/codesign", args: ["--force", "--sign", "-", "{{appdir}}/Melodica.app"], must_succeed: false
  end
end
