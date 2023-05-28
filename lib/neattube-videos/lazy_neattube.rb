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
    ::Onebox::Helpers.video_placeholder_html
  end

  def to_html
    video_src = Nokogiri::HTML5.fragment(oembed_data[:html]).at_css("iframe")&.[]("src")
    video_src = og_data[:video] if video_src.blank?
    video_src = video_src.gsub("autoplay=1", "").chomp("?")

    iframe_id = video_src.sub("https://neat.tube/videos/embed/", "")

    <<~HTML
      <div class="neattube-onebox neattube-video-container"
        data-video-id="#{iframe_id}"
        data-video-title="#{og_data.title}"
        data-provider-name="neattube">
        <a href="#{og_data.url}" target="_blank">
          <img class="neattube-thumbnail"
            src="#{og_data.image}"
            title="#{og_data.title}">
        </a>
      </div>
    HTML
  end

  private

  def oembed_data
    @oembed_data = get_oembed
  end

  def og_data
    @og_data = get_opengraph
  end
end
