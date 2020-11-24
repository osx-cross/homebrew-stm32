cask 'stm32cubemx@5' do
	module Utils
		def self.version_suffix
			 return "@5"
		end

		def self.cubemx_original_app_path
			 return "/Applications/STMicroelectronics/STM32CubeMX.app"
		end

		def self.cubemx_final_app_path
			 return "/Applications/STMicroelectronics/STM32CubeMX#{self.version_suffix}.app"
		end

		def self.usr_local_bin_file
			 return "/usr/local/bin/stm32cubemx#{self.version_suffix}"
		end

		def self.cubemx_script_file
			 return "#{self.cubemx_final_app_path}/Contents/MacOs/stm32cubemx.sh"
		end
	end

  version '5.6.1'
  sha256 'ff3ed237790529b2134f2254789220d7def05669857d5e0e1e60d387c17ab4bb'

  url "https://dl.bintray.com/osx-cross/casks-stm32/en.stm32cubemx_v#{version}.zip"
  name 'STM32CubeMX'
  homepage 'https://www.st.com/en/development-tools/stm32cubemx.html'

  auto_updates false

  installer script: {
    executable: 'java',
    args:       ['-jar', "#{staged_path}/SetupSTM32CubeMX-#{version}.exe"],
    must_succeed: true
	}

	postflight do
    unless Utils.version_suffix.empty?
      ohai "Adding #{Utils.version_suffix} to STM32CubeMX.app filename"
      FileUtils.mv Utils.cubemx_original_app_path Utils.cubemx_final_app_path
		end

    File.open(Utils.cubemx_script_file, "w") { |f|
      f.write("#!/usr/bin/env bash\njava -jar #{Utils.cubemx_final_app_path}/Contents/MacOs/STM32CubeMX $@\n")
      f.close
    }

    FileUtils.chmod 0755, Utils.cubemx_script_file
    FileUtils.ln_sf Utils.cubemx_script_file, Utils.usr_local_bin_file
  end

  uninstall script: {
    executable: 'java',
    args:       ['-jar', '#{Utils.cubemx_final_app_path}/Contents/Resources/Uninstaller/uninstaller.jar'],
    must_succeed: true
  }

  uninstall_preflight do
    FileUtils.rm Utils.usr_local_bin_file, force: true
  end

  caveats do
    depends_on_java
  end
end
