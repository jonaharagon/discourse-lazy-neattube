import Component from "@glimmer/component";

export default class NeattubeVideo extends Component {
  get iframeSrc() {
    switch (this.args.providerName) {
      case "youtube":
        let url = `https://www.youtube.com/embed/${this.args.videoId}?autoplay=1`;
        if (this.args.startTime > 0) {
          url += `&start=${this.args.startTime}`;
        }
        return url;
      case "vimeo":
        return `https://player.vimeo.com/video/${this.args.videoId}${
          this.args.videoId.includes("?") ? "&" : "?"
        }autoplay=1`;
      case "tiktok":
        return `https://www.tiktok.com/embed/v2/${this.args.videoId}`;
    }
  }
}
