# frozen_string_literal: true

# name: discourse-peertube-onebox
# about: Onebox and lazy loading support for PeerTube videos
# version: 0.1
# authors: Jonah Aragon, Jan Cernik
# url: https://github.com/jonaharagon/discourse-lazy-peertube

hide_plugin if self.respond_to?(:hide_plugin)
enabled_site_setting :lazy_videos_enabled

require "onebox"
require_relative "lib/onebox/engine/peertube_onebox"
require_relative "lib/lazy-videos/lazy_peertube"

after_initialize do
  on(:reduce_cooked) do |fragment|
    fragment
      .css(".lazy-video-container")
      .each do |video|
        title = video["data-video-title"]
        href = video.at_css("a")["href"]
        video.replace("<p><a href=\"#{href}\">#{title}</a></p>")
      end
  end
end
