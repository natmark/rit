require 'inifile'

module Rit
  class Config
    attr_reader :inifile

    def self.load(config_path)
      inifile = IniFile.load(config_path)
      Config.new(inifile)
    end

    def initialize(inifile)
      @inifile = inifile
    end

    def set(section_name, key, value)
      @inifile[section_name][key] = value
    end

    def write
      @inifile.write
    end
  end
end
