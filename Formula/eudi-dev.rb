# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the dominikschlosser/homebrew-tap
# repository by the release workflow. 2.4.4 (without the leading v) and
# 9b63e852e3c37dae64269c6325d559c77b63d45b72061fcfcde0299f16f8e00f are filled in per release.
class EudiDev < Formula
  desc "Developer toolkit for the EUDI and OpenID4VC ecosystem"
  homepage "https://github.com/dominikschlosser/eudi-dev"
  url "https://github.com/dominikschlosser/eudi-dev/archive/refs/tags/v2.4.4.tar.gz"
  sha256 "9b63e852e3c37dae64269c6325d559c77b63d45b72061fcfcde0299f16f8e00f"
  license "Apache-2.0"
  head "https://github.com/dominikschlosser/eudi-dev.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/dominikschlosser/eudi-dev/v2/cmd.Version=v#{version}"
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
