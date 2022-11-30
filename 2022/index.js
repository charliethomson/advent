// Paraphrased from https://github.com/jhuckaby/clipdown, thanks!

const breakdance = require("breakdance");
const { htmlToText } = require("html-to-text");
const sanitizeHTML = require("sanitize-html");

// var hex = RegExp.$1;

const stdin = process.stdin;
let data = "";

stdin.setEncoding("utf8");

stdin.on("data", function (chunk) {
  data += chunk;
});

stdin.on("end", function () {
  var shtml = sanitizeHTML(data, {
    // sanitize-html doesn't allow h1 or h2 by default (facepalm) so we have to add them
    allowedTags: sanitizeHTML.defaults.allowedTags.concat(["h1", "h2"]),
  });
  console.log(htmlToText(shtml));
});

stdin.on("error", console.error);
