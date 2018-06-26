# encoding: utf-8
require 'spec_helper'
require "logstash/filters/decoder"

describe LogStash::Filters::Decoder do
  describe "Decoded text should be Hello word" do
    let(:config) do <<-CONFIG
      filter {
        decoder {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "H4sIAAAAAAAAA/NIzcnJVyjPL0oBACpAl2kKAAAA") do
      expect(subject.get("message")).to eq('Hello word')
    end
  end
end
