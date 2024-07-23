// ==================== INITIALIZE EXPRESS APP ====================
const express = require("express");
const app = express();
const fileUpload = require('express-fileupload');
app.use(fileUpload());
// ====================  GLOBAL MIDDLEWARE ====================
app.use(express.json());
app.use(express.urlencoded({ extended: true })); // TO ACCESS URL FORM ENCODED
app.use(express.static("upload"));
const cors = require("cors");
app.use(cors()); // ALLOW HTTP REQUESTS LOCAL HOSTS
 // ====================  Required Module ====================
 const auth = require("./routes/Auth");
 const monument = require("./routes/monument");
 const trip = require("./routes/trip");
 const search = require("./routes/search");
 const profile = require("./routes/profile");
  const favourite = require("./routes/favourite");
 const MLIntegration = require("./routes/MLIntegration");
 // ====================  RUN THE APP  ====================
app.listen(3000, "localhost", () => {
    console.log("SERVER IS RUNNING ");
  });
// ====================  API ROUTES [ ENDPOINTS ]  ====================
 app.use("/auth", auth);
 app.use("/monument", monument);
 app.use("/trip", trip);
 app.use("/search",search);
 app.use("/profile",profile);
 app.use("/favourite", favourite);
 app.use("/MLIntegration", MLIntegration);
 
