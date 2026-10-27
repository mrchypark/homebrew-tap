class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.13.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.13.0/yeoul_0.13.0_darwin_arm64.tar.gz"
      sha256 "441948c89604478397149061dc90d102129dfbd52369181c5bdb7976e5a7fa3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.13.0/yeoul_0.13.0_darwin_amd64.tar.gz"
      sha256 "60a2a3bafa05b92ad8cce027cdb82f248e8cc3d5ad2e8fa53355561c2462d809"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.13.0/yeoul_0.13.0_linux_arm64.tar.gz"
      sha256 "fc2461dec5dbb8ff32b5cdf3601de4beceb8bef383ff57eacc6985cd37aeb0f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.13.0/yeoul_0.13.0_linux_amd64.tar.gz"
      sha256 "14ecb44dbaaa29b04926aed5dc95167b6d53d93ce55ff816d06dddb65fd05bb6"
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
