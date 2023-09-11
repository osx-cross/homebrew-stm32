cask "stm32cubeide" do
  version "1.6.0"
  sha256 :no_check

  url "https://www.dropbox.com/s/5n4qgtjvp9ehnei/en.stm32cubeide_v1.6.0.dmg?dl=1", header: "", data: nil,
      verified: "dropbox.com/s/5n4qgtjvp9ehnei"
  name "STM32CubeIDE"
  desc "Integrated Development Environment for STM32"
  homepage "https://www.st.com/en/development-tools/stm32cubeide.html"

  auto_updates true

  app "STM32CubeIDE.app"
  pkg "st-stlink-server.2.0.2-1.pkg"

  uninstall quit: "com.st.stm32cube.ide.mcu.rcp.product"

  caveats do
    depends_on_java
  end
end
