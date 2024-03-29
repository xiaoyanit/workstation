#!/usr/bin/env ruby

require 'rubygems'
require 'rexml/document'
require 'thor'

include REXML

class AndroidLocalSQLite < Thor
  desc "dump", "dump the database attached to this project"
  method_option :manifest, :type => :string, :aliases => "-m", :default => "#{Dir.pwd}/AndroidManifest.xml", :desc => "location of the AndroidManifest.xml for the project"
  method_option :database_name, :type => :string, :aliases => "-n", :desc => "Database name defaulted to package name with '.db' as suffix (i.e. com.test.db)"
  def dump
    begin
      manifest = Document.new(File.new(options[:manifest]))
    rescue Exception=>e
      puts "Could not find AndroidManifest.xml, execute from root of your project or use -m option to specify the location of the manifest"
      exit(0)
    end
    package = package(manifest)
    dbname = options[:database_name]
    dbname ||= package + ".db"
    exec "adb shell sqlite3 /data/data/#{package}/databases/#{dbname} .dump"
  end

  desc "select", "select from the database attached to this project"
  method_option :manifest, :type => :string, :aliases => "-m", :default => "#{Dir.pwd}/AndroidManifest.xml", :desc => "location of the AndroidManifest.xml for the project"
  method_option :database_name, :type => :string, :aliases => "-n", :desc => "Database name defaulted to package name with '.db' as suffix (i.e. com.test.db)"
  method_option :table_name, :type => :string, :aliases => "-t", :option => :required, :desc => "the table name being selected"
  method_option :fields, :type => :array, :aliases => "-f", :desc => "the fields to select"
  method_option :raw, :type => :string, :desc => "execute a raw select (omiting the select)"
  def select
    begin
      manifest = Document.new(File.new(options[:manifest]))
    rescue Exception=>e
      puts "Could not find AndroidManifest.xml, execute from root of your project or use -m option to specify the location of the manifest"
      exit(0)
    end
    package = package(manifest)
    dbname = options[:database_name]
    dbname ||= package + ".db"
    if options.raw
      exec "adb shell sqlite3 /data/data/#{package}/databases/#{dbname} 'select #{options[:raw]};'"
    else
      fields = options[:fields].join"," unless options[:fields].nil?
      fields ||= "*"
      exec "adb shell sqlite3 /data/data/#{package}/databases/#{dbname} 'select #{fields} from #{options[:table_name]};'"
    end
  end


  private
    def package(manifest)
      XPath.each(manifest, "//manifest@package").first.attribute("package").value
    end
end

AndroidLocalSQLite.start