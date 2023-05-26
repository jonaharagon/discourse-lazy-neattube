# frozen_string_literal: true

class Onebox::Engine::PeertubeOnebox
  include Onebox::Engine
  alias_method :default_onebox_to_html, :to_html

  def to_html
    if SiteSetting.lazy_videos_enabled && SiteSetting.lazy_peertube_enabled
      video_src = Nokogiri::HTML5.fragment(oembed_data[:html]).at_css("iframe")&.[]("src")
      video_src = video_src.gsub("autoplay=1", "").chomp("?")

      <<~HTML
        <div class="peertube-onebox lazy-video-container"
          data-video-id="#{iframe_id}"
          data-video-title="#{oembed_data.title}"
          data-provider-name="peertube">
          <a href="#{video_src}" target="_blank">
            <img class="peertube-thumbnail"
              src="#{oembed_data.thumbnail_url}"
              title="#{oembed_data.title}">
          </a>
        </div>
      HTML
    else
      default_onebox_to_html
    end
  end
end
