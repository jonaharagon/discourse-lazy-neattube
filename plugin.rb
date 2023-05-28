# frozen_string_literal: true

# name: discourse-lazy-neattube
# about: Lazy loading support for Neat.Tube videos
# version: 0.1
# authors: Jonah Aragon, Jan Cernik
# url: https://github.com/jonaharagon/discourse-lazy-neattube

enabled_site_setting :lazy_neattube_enabled

require "onebox"
require_relative "lib/neattube-videos/lazy_neattube"

after_initialize do
  on(:reduce_cooked) do |fragment|
    fragment
      .css(".neattube-video-container")
      .each do |video|
        title = video["data-video-title"]
        href = video.at_css("a")["href"]
        video.replace("<p><a href=\"#{href}\">#{title}</a></p>")
      end
  end
end