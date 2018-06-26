# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "base64"
require 'zlib'
require 'stringio'

# This filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an.
class LogStash::Filters::Decoder < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   decoder {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "decoder"

  # Replace the message with this value.
  config :message, :validate => :string, :default => "Hello World!"


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    begin
        zip = Base64.decode64(event.get("message"));
        gz = Zlib::GzipReader.new(StringIO.new(zip))
        uncompressed_string = gz.read
        event.set("message", uncompressed_string)
    rescue

    end

    puts ">>>"
    puts event.get("message")

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Decoder
