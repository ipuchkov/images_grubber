#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require_relative 'lib/img_grub'

if __FILE__ == $PROGRAM_NAME
 ImgGrub.grub_images(ARGV.first, ARGV.last)
 puts 'Downloaded'
end
