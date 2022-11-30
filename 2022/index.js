// Paraphrased from https://github.com/jhuckaby/clipdown, thanks!

const sanitizeHTML = require("sanitize-html");
const { NodeHtmlMarkdown } = require("node-html-markdown");

// var hex = RegExp.$1;

const stdin = process.stdin;
let data = "";

stdin.setEncoding("utf8");

stdin.on("data", function (chunk) {
  data += chunk;
});

stdin.on("end", function () {
  const mainData = data
    .split('<article class="day-desc">')[1]
    .split("</article>")[0];
  const shtml = sanitizeHTML(mainData, {
    allowedTags: sanitizeHTML.defaults.allowedTags.concat(["h1", "h2"]),
  });
  const md = NodeHtmlMarkdown.translate(shtml, {
    emDelimiter: "**",
    useLinkReferenceDefinitions: true,
  });

  console.log(md);
});

stdin.on("error", console.error);
