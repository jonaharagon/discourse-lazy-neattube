# frozen_string_literal: true

module Onebox
  module Engine
    class PeertubeOnebox
      include Engine
      include StandardEmbed

      matches_regexp(%r{^https?://(\w|\.|-){3,63}/w/\w{22}(/\w+)?})
      always_https

      def placeholder_html
        <<-HTML
          <img src="#{oembed_data.thumbnail_url}" style="max-width: #{oembed_data.width}px; max-height: #{oembed.height}px;" title="#{oembed.title}">
        HTML
      end

      def to_html
        return peertube_html if is_peertube?
      end

      def peertube_html
        video_src = Nokogiri::HTML5.fragment(oembed_data[:html]).at_css("iframe")&.[]("src")
        video_src = video_src.gsub("autoplay=1", "").chomp("?")

        <<-HTML
          <iframe
            class="peertube-onebox"
            src="#{video_src}"
            data-original-href="#{link}"
            frameborder="0"
            allowfullscreen
          ></iframe>
        HTML
      end

      def is_peertube?
        oembed_data[:provider_name] == "PeerTube" &&
          !Onebox::Helpers.blank?(data[:video])
      end

      private

      def oembed_data
        @oembed_data = get_oembed
      end
    end
  end
end
