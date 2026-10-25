class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.11.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.1/yeoul_0.11.1_darwin_arm64.tar.gz"
      sha256 "24bd418d91690f39f8d0115d343a5965f93e2530694c9099b457110c792124e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.1/yeoul_0.11.1_darwin_amd64.tar.gz"
      sha256 "9e5e5e2d483bead075e23283cb88d192f5d442419b1b09797500224527645b12"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.1/yeoul_0.11.1_linux_arm64.tar.gz"
      sha256 "759b6db6da47da615b831eb931bc75ed030ccd9eb6d803a181a10fc2fb820729"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.1/yeoul_0.11.1_linux_amd64.tar.gz"
      sha256 "f9fd1fe9b0c6735a5cf9a4ee58074d519f45ffa6bf3682fb2e8a50bff1345751"
    end
  end

  def install
    libexec.install Dir["*"]

    runtime_env = {}
    if OS.mac?
      runtime_env["DYLD_LIBRARY_PATH"] = libexec/"lib"
    elsif OS.linux?
      runtime_env["LD_LIBRARY_PATH"] = libexec/"lib"
    end

    (bin/"yeoul").write_env_script libexec/"bin/yeoul", runtime_env
    (bin/"yeould").write_env_script libexec/"bin/yeould", runtime_env
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/yeoul help")
  end
end
