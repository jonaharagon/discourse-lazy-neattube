# frozen_string_literal: true
require "onebox"

class Onebox::Engine::NeattubeOnebox
  include Onebox::Engine
  include Onebox::Engine::StandardEmbed

  def self.priority
      0
  end

  matches_regexp(%r{^https?://neat\.tube/(w|videos/watch)/(\w{22}|[\w-]{36})})
  requires_iframe_origins "https://neat.tube"
  always_https

  def placeholder_html
    og_data = get_opengraph

    <<~HTML
      <img class="neattube-thumbnail"
        src="#{og_data.image}"
        title="#{og_data.title}">
    HTML
  end

  def to_html
    og_data = get_opengraph
    video_src = og_data.video_secure_url
    video_src = video_src.gsub("autoplay=1", "").chomp("?")

    iframe_id = video_src.sub("https://neat.tube/videos/embed/", "")

    <<~HTML
      <div class="neattube-onebox neattube-video-container"
        data-video-id="#{iframe_id}"
        data-video-title="#{og_data.title}"
        data-instance-name="neattube">
        <a href="#{og_data.url}" target="_blank">
          <img class="neattube-thumbnail"
            src="#{og_data.image}"
            title="#{og_data.title}">
        </a>
      </div>
    HTML
  end

end
