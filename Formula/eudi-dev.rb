# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the dominikschlosser/homebrew-tap
# repository by the release workflow. 1.18.4 (without the leading v) and
# 608ada1862e188f93c502363e799f7739cf4736129f73c8fcd09a99a76af7139 are filled in per release.
class EudiDev < Formula
  desc "Developer toolkit for the EUDI and OpenID4VC ecosystem"
  homepage "https://github.com/dominikschlosser/eudi-dev"
  url "https://github.com/dominikschlosser/eudi-dev/archive/refs/tags/v1.18.4.tar.gz"
  sha256 "608ada1862e188f93c502363e799f7739cf4736129f73c8fcd09a99a76af7139"
  license "Apache-2.0"
  head "https://github.com/dominikschlosser/eudi-dev.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/dominikschlosser/eudi-dev/cmd.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"eudi")
    # Legacy command name keeps working for the time being
    bin.install_symlink "eudi" => "oid4vc-dev"
    generate_completions_from_executable(bin/"eudi", "completion")
  end

  test do
    assert_match "eudi", shell_output("#{bin}/eudi version")
    assert_match "german-pid-sdjwt", shell_output("#{bin}/eudi templates list --wallet-dir #{testpath}")
  end
end
