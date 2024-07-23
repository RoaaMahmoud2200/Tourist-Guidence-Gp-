const router = require("express").Router();
const { body,validationResult } = require("express-validator");
const conn = require("../db/dbConnection");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const util = require("util");
const { log, Console } = require("console");
const authorized = require("../middleware/authorize");
const admin= require("../middleware/admin");
const session = require('express-session');

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





//changePassword
router.put(
  "/changePassword",authorized,
  body("oldpassword")
  .isLength({ min: 8, max: 12 })
  .withMessage("password should be between (8-12) character"),
  body("newPassword")
  .isLength({ min: 8, max: 12 })
  .withMessage("password should be between (8-12) character"),
  async (req, res) => {
    try {
      // 1- VALIDATION REQUEST [manual, express validation]
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const query = util.promisify(conn.query).bind(conn);
      
        // 3- COMPARE HASHED PASSWORD
        const checkPassword = await bcrypt.compare( req.body.oldpassword,res.locals.user.password );

        if (!checkPassword) {
          return res.status(405).json({ ms: 'password is wrong' });
        }
      
        const newHashedPassword={
            id:res.locals.user.id,
            email: res.locals.user.email,  
            user_name: res.locals.user.user_name,
            password: await bcrypt.hash(req.body.newPassword, 10),
            age:res.locals.user.age, 
            mobile_num:res.locals.user.mobile_num,
            language :res.locals.user.language,
            currency:res.locals.user.currency,
            token:res.locals.user.token, 
         
        }
        await query("update users set ? where id = ?", [newHashedPassword, res.locals.user.id]);

        res.status(200).json( {ms :" password  is changed"});  
  }

  catch (err) {
    console.log(err);
    res.status(500).json(err);
  }}
)


//------------------------------------------------------
//update
router.put(
  "/:id", // params
 body("email")
    .isEmail()
    .withMessage("please enter a valid email!"),

    body("user_name")
    .isString()
    .withMessage("please enter a valid user_name")
    .isLength({ min: 3, max: 20 })
    .withMessage("name should be between (3-20) character"),
 
    body("age")  
    .isLength({min:1})
    .withMessage("please enter a valid age"),

    body("mobile_num")
    .isMobilePhone()
    .withMessage(" mobile_num should be number")
    .isLength({ min: 11 , max: 12 })
    .withMessage("mobile_num should be 11 number "),

    body("language")
    .isString()
    .withMessage("language should be a string ")
    .isLength({ min: 2 , max: 10 })
    .withMessage(" please enter a valid language"),
   
    body("currency")
    .isString()
    .withMessage("please enter a valid currency should be a string")
    .isLength({ min: 2 , max: 10 })
    .withMessage("please enter a valid currency "),
    
  async (req, res) => {
    try {
      // 1- VALIDATION REQUEST [manual, express validation]
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
    
     // 2- CHECK IF user EXISTS OR NOT
     const query = util.promisify(conn.query).bind(conn); // transform query mysql --> promise to use [await/async]
      const user = await query("select * from users where id = ?", [
        req.params.id,
      ]);
      if (!user[0]) {
        return res.status(401).json({ ms: "user not found !" });
      }

        // 3- CHECK IF EMAIL EXISTS
      const checkEmailExists = await query(
        "select * from  users where email = ?",
        [req.body.email]
      );
      
        if (checkEmailExists.length > 0 && req.params.id!=checkEmailExists[0].id) {
        return res.status(402).json({ ms: "email already exists for anthor user, enter another email"});
      }  
      // 3- PREPARE OBJECT USER TO -> SAVE
      const updateData = {
          
          email: req.body.email,  
          user_name: req.body.user_name,
          password: user[0].password,
          age:req.body.age, 
          mobile_num: req.body.mobile_num,
          language :req.body.language,
          currency:req.body.currency,
          token: crypto.randomBytes(16).toString("hex"), 
      };
      // 4- UPDATE 
      await query("update users set ? where id = ?", [updateData, user[0].id]);

      res.status(200).json({ms: "userProfile updated successfully"});

      
    } catch (err) {
      res.status(500).json(err);
    }}
)
//-----------------------------------------------------------
//delete user by admin
router.delete(
    "/:id", // params
    admin,
    async (req, res) => {
      try {
        // 1- CHECK IF user EXISTS OR NOT
        const query = util.promisify(conn.query).bind(conn);
        const DeletedUser = await query("select * from users where id = ?", [
          req.params.id,
        ]);
        if (!DeletedUser[0]) {
          res.status(401).json({ ms: "User not found !" });
        }
        // 2- REMOVE User 
        await query("delete from users where id = ?", [DeletedUser[0].id]);
        res.status(200).json({ ms: "user delete successfully"});
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
//-------------------------------------------------------
  // LIST all users [ADMIN]  
router.get("", admin , async (req, res) => {

    const query = util.promisify(conn.query).bind(conn);
    const usersProfile = await query(`select * from users`);
    
    res.status(200).json(usersProfile);
  });
//-------------------------------------------------------
  // LIST all booking [ADMIN]  
  
  router.get("/allBooking", admin , async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const booking = await query(`select t.*,  u.user_name,u.email,u.mobile_num
    from trip t join 	reservation r
    on t.id=r.trip_id	join users u
    on u.id=r.user_id
    order by r.trip_id
    	`);
     

      res.status(200).json(booking);
    });
   
    //-------------------------------------------------------
  // LIST all booking for specfic trip [ADMIN]  
  
  router.get("/allBookingForSpecificTrip/:id", admin , async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const booking = await query(`select  u.user_name,u.email,u.mobile_num
    from trip t join 	reservation r
    on t.id=r.trip_id	join users u
    on u.id=r.user_id
    where r.trip_id=?`,req.params.id);
    if (!booking[0]) {
      return res.status(440).json({ ms: "no user reserve that trip" });
    }

      res.status(200).json(booking);
    });
   
//-------------------------------------------------------
  // list all trips with the users reserve it 
  
  router.get("/allBookingTripsWithUsersReserveIt",admin, async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const trip = await query(`select  distinct t.* from trip t join reservation r on t.id=r.trip_id`);
   
    
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
     await query("delete from trip where id = ?",trip[y].id)}
    } 
   

    for(let x=0;x<trip.length;x++){
      delete trip[x].description
      delete trip[x].image_url
      trip[x].users=await query(
        `select  u.user_name,u.email,u.mobile_num from trip t join 
        	reservation r on t.id=r.trip_id	join users u on u.id=r.user_id where r.trip_id= ? `,
          trip[x].id
      );

    }
    res.status(200).json(trip);
  });

  //-------------------------------------------------------
   // LIST all reservation for specific user
router.get("/booking", authorized , async (req, res) => {

  const query = util.promisify(conn.query).bind(conn);
  const reservation = await query(`select * from reservation where user_id=?`,res.locals.user.id);
  if (!reservation[0]) {
    return res.status(440).json({ ms: "no reservation" });
  }
  const x = [];
let tripsReservaed = [{}];

for (let index = 0; index < reservation.length; index++) {
  tripsReservaed=await query(
   "select * from  trip where id = ?", reservation[index].trip_id);
   delete tripsReservaed[0].description;
   tripsReservaed.map((tripsReservaed) => {
    tripsReservaed.image_url = "http://" + req.hostname + ":3000/" + tripsReservaed.image_url;
  }
  );
   tripsReservaed.forEach((object)=>{
    x.push(object);
  });
 }
  res.status(200).json(x);
});

 
//-------------------------------------------------------
// cancel reservation 
  router.delete(
    "/booking/:id", // params
    authorized,
    async (req, res) => {
      try {
        // 1- CHECK IF trip EXISTS OR NOT
        const query = util.promisify(conn.query).bind(conn);
        const reservation = await query("select * from reservation where trip_id = ?", [
          req.params.id,
        ]);
        if (!reservation[0]) {
          return res.status(440).json({ ms: " not reserved" });
        }
        const trip = await query("select * from trip where id = ?", [
          req.params.id,
        ]);
        const updatedTripWithNumOfReservatio={
          destination :trip[0].destination ,
          description:trip[0].description,
          price:trip[0].price,
          num_of_reservation:(trip[0].num_of_reservation)+1,
       };
     await query("update trip set ? where id = ?", [updatedTripWithNumOfReservatio, req.params.id]);
        // 2- REMOVE trip 
        await query("delete from reservation where trip_id = ? and user_id=?", [req.params.id ,res.locals.user.id]);
        res.status(200).json({ ms: "reservation cancelled successfully"});

      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
module.exports = router;