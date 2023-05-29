import Component from "@glimmer/component";

export default class NeattubeVideo extends Component {
  get iframeSrc() {
    switch (this.args.instanceName) {
      case "neattube":
        let url = `https://neat.tube/videos/embed/${this.args.videoId}?autoplay=1`;
        if (this.args.startTime > 0) {
          url += `&start=${this.args.startTime}`;
        }
        return url;
    }
  }
}
