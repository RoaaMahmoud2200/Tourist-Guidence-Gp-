const router = require("express").Router();
const conn = require ("../db/dbConnection");
const { body, validationResult } = require("express-validator");
const authorized = require("../middleware/authorize");
const admin = require("../middleware/admin");
const upload = require("../middleware/uploadImages");
const fs = require("fs"); // file system
const util = require("util"); // helper 

const monthMap = {
  'Jan': 1,
  'Feb': 2,
  'Mar': 3,
  'Apr': 4,
  'May': 5,
  'Jun': 6,
  'Jul': 7,
  'Aug': 8,
  'Sep': 9,
  'Oct': 10,
  'Nov': 11,
  'Dec': 12,
};

function getMonthNumber(shortMonth) {
  if (monthMap.hasOwnProperty(shortMonth)) {
    return monthMap[shortMonth];
  } else {
    // Handle invalid short month input
    return -1; // or throw an error
  }
}


// CREATE monument [ADMIN]
router.post(
  "", admin,
  upload.single("image_url"),
  body("destination")
  .isString()
  .withMessage(" destination should be a string "),

body("description")
  .isString()
  .withMessage(" description should be a string  ")
  .isLength({ min: 10 })
  .withMessage("description should be at lease 20 characters"),

  body("price")
  .isNumeric()
  .withMessage(" price should be a number"),

  body("num_of_reservation")
  .isNumeric()
  .withMessage(" price should be a number"),



  async (req, res) => {
    try {
      // 1- VALIDATION REQUEST [manual, express validation]
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
   
    // 2- VALIDATE THE IMAGE
    if (!req.file) {
      return res.status(409).json({ms: "Image is Required",});
    }
      // 3- PREPARE TRIP object
      const tripObject = {
        destination :req.body.destination ,
        description: req.body.description,
        price:req.body.price,
        num_of_reservation:req.body.num_of_reservation,
        image_url: req.file.filename
      };
  // 4 - INSERT tript INTO DB
  const query = util.promisify(conn.query).bind(conn);
  await query("insert into trip set ? ",  tripObject);
  res.status(200).json({ms:" trip created successfully !"});
    } catch (err) {
      console.log(err)
      res.status(500).json(err);
    }
  }
);
//-------------------------------------------------------
  // UPDATE trip [ADMIN]
router.put(
    "/:id", // params
    admin,
    upload.single("image_url"),
    body("destination")
    .isString()
    .withMessage(" destination should be a string "),
  
  body("description")
    .isString()
    .withMessage(" description should be a string  ")
    .isLength({ min: 10 })
    .withMessage("description should be at lease 20 characters"),
  
    body("price")
    .isNumeric()
    .withMessage(" price should be a number"),
  
    body("num_of_reservation")
    .isNumeric()
    .withMessage(" price should be a number"),
  
  
    async (req, res) => {
      try {
        // 1- VALIDATION REQUEST [manual, express validation]
        const query = util.promisify(conn.query).bind(conn);
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
        // 3- CHECK IF trip EXISTS OR NOT
        const trip = await query("select * from trip where id = ?", [
          req.params.id,
        ]);
        if (!trip[0]) {
          return res.status(413).json({ ms: "trip not found !" });
        }
        // 3- PREPARE TRIP object
        const tripObject = {
          destination :req.body.destination ,
          description: req.body.description,
          price:req.body.price,
          num_of_reservation:req.body.num_of_reservation,
        };

        if (req.file) {
          tripObject.image_url = req.file.filename;
          fs.unlinkSync("./upload/" + trip[0].image_url); // delete old image
        }
  
        // 4- UPDATE trip
        await query("update trip set ? where id = ?", [tripObject, trip[0].id]);
  
        res.status(200).json({ms: "trip  updated successfully",});
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
//-------------------------------------------------------
  // DELETE trip [ADMIN]
router.delete(
    "/:id", // params
    admin,
    async (req, res) => {
      try {
        // 1- CHECK IF trip EXISTS OR NOT
        const query = util.promisify(conn.query).bind(conn);
        const trip = await query("select * from trip where id = ?", [
          req.params.id,
        ]);
        if (!trip[0]) {
        return  res.status(413).json({ ms: "trip not found !" });
        }
        // 2- REMOVE trip image
        fs.unlinkSync("./upload/" + trip[0].image_url); // delete old image
        // 2- REMOVE trip 
        await query("delete from trip where id = ?", [trip[0].id]);
        res.status(200).json({ ms: "trip delete successfully"});
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
async function showIfTripExpired (){

}
//-------------------------------------------------------
  // LIST  [ADMIN, USER]
  
router.get("", async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const trip = await query(`select * from trip`);
    //chevk the avalability of trips 
    const currentDate=new Date()
    const monthFromCurrent=currentDate.toLocaleDateString('en-us',{month:'short'})
    const dayFromCurrent=String(currentDate.getDate()).padStart(2,'0')
    for(let y=0;y<trip.length;y++){

      let tripDate=trip[y].destination.slice(-6)
      let tripMonth=tripDate.slice(-3)
      let tripDay=tripDate.substring(0,2)

 if(getMonthNumber(tripMonth)<getMonthNumber(monthFromCurrent)   || ((tripMonth)=getMonthNumber(monthFromCurrent) && tripDay<dayFromCurrent)   )
   {
     await query("delete from trip where id = ?",trip[y].id)
    //return res.status(200).json({ms:"this trip is expired"});
   }
    }
    trip.map((trip) => {
      trip.image_url = "http://" + req.hostname + ":3000/" + trip.image_url;
    }
    );
    
    res.status(200).json(trip);
  });

 //-------------------------------------------------------

 // SHOW trip [ADMIN, USER]
router.get("/:id", async (req, res) => {
  const query = util.promisify(conn.query).bind(conn);
  const trip = await query("select * from trip where id = ?", [
    req.params.id,
  ]);
 // check the id 
  if (!trip[0]) {
   return res.status(413).json({ ms: "trip not found !" });
  }
 // check tha avalability of trip 
 let tripDate=trip[0].destination.slice(-6)
 let tripMonth=tripDate.slice(-3)
 let tripDay=tripDate.substring(0,2)
 const currentDate=new Date()
 const monthFromCurrent=currentDate.toLocaleDateString('en-us',{month:'short'})
 const dayFromCurrent=String(currentDate.getDate()).padStart(2,'0')
 
 if(getMonthNumber(tripMonth)<getMonthNumber(monthFromCurrent)   || ((tripMonth)=getMonthNumber(monthFromCurrent) && tripDay<dayFromCurrent)   )
   {
     await query("delete from trip where id = ?",trip[0].id)
    return res.status(200).json({ms:"this trip is unavaliable"});
   }
 //get the trip image 
  trip[0].image_url = "http://" + req.hostname + ":3000/" + trip[0].image_url;
  trip[0].reviews = await query(
    "select * from user_trip_review where trip_id = ?",
    trip[0].id
  );
  for (let index = 0; index <  trip[0].reviews.length; index++) {
    delete  trip[0].reviews[index].trip_id,
    delete  trip[0].reviews[index].user_id
  }
  res.status(200).json(trip[0]);
});
//------------------------------------------------------------------------------
// MAKE REVIEW [ADMIN, USER]
router.post(
  "/review",
  authorized,
  body("trip_id").isNumeric().withMessage("please enter a valid trip ID"),
  body("review").isString().withMessage("please enter a valid Review"),
  async (req, res) => {
    try {
      const query = util.promisify(conn.query).bind(conn);

      // 1- VALIDATION REQUEST [manual, express validation]
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      // 2- CHECK IF monument EXISTS OR NOT
      const trip = await query("select * from trip where id = ?", [
        req.body.trip_id,
      ]);
      if (!trip[0]) {
        return  res.status(413).json({ ms: "trip not found !" });
      }
      const x=  await query( "select * from user_trip_review where user_id = ? AND trip_id= ?",[res.locals.user.id,req.body.trip_id]  );
       if (x[0]){
        return res.status(410).json({ ms: "you already do a review for this item" });
       }
      // 3 - PREPARE trip REVIEW OBJECT
      const reviewObj = {
        user_id: res.locals.user.id,
        user_name: res.locals.user.user_name,
        trip_id: trip[0].id,
        review: req.body.review,
      };

      // 4- INSERT monument OBJECT INTO DATABASE
      await query("insert into user_trip_review set ?", reviewObj);
      delete reviewObj.user_id;
      res.status(200).json({
        ms: "review added successfully !"});
    } catch (err) {
      console.log(err);
      res.status(500).json(err);
    }}
);



//----------------------------------------------------------
//Booking trip 
router.post(
  "/:id", // params
  authorized,
 
  async (req, res) => {
    try {
      // 1- CHECK IF trip EXISTS OR NOT
      const query = util.promisify(conn.query).bind(conn);
      // show if trip exist or not
      const trip = await query("select * from trip where id = ?",req.params.id );
      if (!trip[0]) {
        return res.status(413).json({ ms: "trip not found !" });
      }
     // show if this user reserve this trip before 
      const user = await query("select * from reservation where user_id = ? and trip_id=?",[res.locals.user.id ,req.params.id]);
      if (user[0]) {
        return res.status(450).json({ ms: "you aleardy reserve this trip " });
      }
    //check num of reservation 
   if (trip[0].num_of_reservation==0) {
    return res.status(448).json({ ms: "There are no reservations !" });
  } else{
    // update num of reservation after booking
    const updatedTripWithNumOfReservatio={
        destination :trip[0].destination ,
        description:trip[0].description,
        price:trip[0].price,
        num_of_reservation:(trip[0].num_of_reservation)-1,
     };
   await query("update trip set ? where id = ?", [updatedTripWithNumOfReservatio, req.params.id]);
    // set reservation object
    const NewReservation={
     trip_id:req.params.id,
     user_id:res.locals.user.id
    };
    await query("insert into reservation set ?", NewReservation);  

    res.status(200).json({ms: "Reservation booked successfully",});
  }
      
    } catch (err) {
      console.log(err);
      res.status(500).json(err);
    }
  }
);




module.exports = router ;