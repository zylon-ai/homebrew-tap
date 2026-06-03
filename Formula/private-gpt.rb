class PrivateGpt < Formula
  desc "Private self-hosted AI API server"
  homepage "https://github.com/zylon-ai/private-gpt"
  url "https://github.com/zylon-ai/private-gpt/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b92fd767ce7474b75de80f3ba025e758ef2d8e1920ab23999bc95fdff160b986"
  license "Apache-2.0"

  depends_on "python@3.11"
  depends_on "uv"

  def install
    (bin/"private-gpt").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" tool run --python "#{Formula["python@3.11"].opt_bin}/python3.11" --find-links "https://wheels.privategpt.dev/packages/" --from "private-gpt[core]==1.0.0" private-gpt "$@"
    SH
  end

  test do
    script = (bin/"private-gpt").read
    assert_match "private-gpt[core]==1.0.0", script
    assert_match "https://wheels.privategpt.dev/packages/", script
    assert_match Formula["uv"].opt_bin.realpath.to_s, script
  end
end
