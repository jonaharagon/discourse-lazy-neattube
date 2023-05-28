export default function getVideoAttributes(cooked) {
  if (!cooked.classList.contains("neattube-video-container")) {
    return {};
  }

  const url = cooked.querySelector("a")?.getAttribute("href");
  const img = cooked.querySelector("img");
  const thumbnail = img?.getAttribute("src");
  const dominantColor = img?.dataset?.dominantColor;
  const title = cooked.dataset.videoTitle;
  const startTime = cooked.dataset.videoStartTime || 0;
  const providerName = cooked.dataset.providerName;
  const id = cooked.dataset.videoId;

  return { url, thumbnail, title, providerName, id, dominantColor, startTime };
}
