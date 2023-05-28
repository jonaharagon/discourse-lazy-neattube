import { withPluginApi } from "discourse/lib/plugin-api";
import getVideoAttributes from "../lib/neattube-video-attributes";
import { hbs } from "ember-cli-htmlbars";

function initNeattubeEmbed(api) {
  api.decorateCookedElement(
    (cooked, helper) => {
      if (cooked.classList.contains("d-editor-preview")) {
        return;
      }

      const neattubeContainers = cooked.querySelectorAll(".neattube-video-container");

      neattubeContainers.forEach((container) => {
        const siteSettings = api.container.lookup("site-settings:main");
        const videoAttributes = getVideoAttributes(container);

        if (siteSettings[`lazy_neattube_enabled`]) {
          const onLoadedVideo = () => {
            const postId = cooked.closest("article")?.dataset?.postId;
            if (postId) {
              api.preventCloak(parseInt(postId, 10));
            }
          };

          const neattubeVideo = helper.renderGlimmer(
            "p.neattube-video-wrapper",
            hbs`<NeattubeVideo @videoAttributes={{@data.param}} @onLoadedVideo={{@data.onLoadedVideo}}/>`,
            { param: videoAttributes, onLoadedVideo }
          );

          container.replaceWith(neattubeVideo);
        }
      });
    },
    { onlyStream: true, id: "discourse-lazy-neattube" }
  );
}

export default {
  name: "discourse-lazy-neattube",

  initialize() {
    withPluginApi("1.6.0", initNeattubeEmbed);
  },
};
