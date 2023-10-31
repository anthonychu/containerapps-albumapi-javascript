var Albums = require("../models/Album");

let requestCounter = 0;
exports.index = async function (req, res) {
  const failures = process.env.API_FAILURES || 0;

  if (failures && requestCounter++ % failures !== 0) {
    // console.log("Albums API failed");
    res.status(500).send("Albums API failed");
    return;
  }

  const albums = await Albums.getAlbums();
  // console.log("Retrieved Albums");
  res.json(albums);
};
