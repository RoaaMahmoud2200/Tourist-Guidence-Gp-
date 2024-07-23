const express = require("express");
const app = express();
const router = require("express").Router();
const conn = require("../db/dbConnection");
const { body, validationResult } = require("express-validator");
const authorized = require("../middleware/authorize");
const util = require("util"); // helpe
const multer=require("multer");
const FormData = require('form-data');
const fs = require('fs');
const path = require('path');
const axios = require('axios');
const upload = require("../middleware/uploadImages");


const fileUpload = require('express-fileupload');
const query = util.promisify(conn.query).bind(conn);


let x=[]
// classification
const uploadDir = path.join(__dirname, 'uploads');
router.post('/classify',authorized, async (req, res) => {
  try {
    // Check if a file was uploaded
    if (!req.files || !req.files.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    // Get the uploaded file
    const uploadedFile = req.files.file;

    // Create the upload directory if it doesn't exist
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir);
    }

    // Save the file to the upload directory
    const filePath = path.join(uploadDir, uploadedFile.name);
    await uploadedFile.mv(filePath);

    // Create a FormData object and append the file
    const formData = new FormData();
    formData.append('file', fs.createReadStream(filePath), uploadedFile.name);

    // Make the POST request to the classification endpoint
    const response = await axios.post('http://127.0.0.1:5000/classify', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
    // get the monument object from db
    const monument = await query("select * from monument where name = ?", [
      response.data.predicted_class,
    ]);
  
    if (!monument[0]) {
      res.status(404).json({ ms: "monument not found !" });
    }
    monument[0].image_url = "http://" + req.hostname + ":3000/" + monument[0].image_url;
    x.push( monument[0]);
    // function to save scanned monumnet 
    const lll= await query(`select * from  scaned_monument where id=?  and user_id=?`,monument[0].id,res.locals.user.id)   ;
    if(!lll[0]){ 
      const monumentObject = {
      id:x[0].id,
      user_id:res.locals.user.id,
      name: x[0].name,
      description: x[0].description,
      location:x[0].location,
      weather :x[0].weather,
      historical_period :x[0].historical_period,
      instructions :x[0].instructions,
      availability :x[0].availability,
      image_url:x[0].image_url.substring(22,42)
    };
      await query(`insert into   scaned_monument set ? `,monumentObject);
      console.log("done")
    }
   
 
    // get monumet reviews
    monument[0].reviews = await query(
      "select * from user_monument_review where monument_id = ?",
      monument[0].id
    );
    let isfav=0 ;
    const isFavQuery = await query(`select * from favourite where monument_id =?`,monument[0].id);
    if(isFavQuery[0]){
      isfav=1;
    }
    for (let index = 0; index <  monument[0].reviews.length; index++) {
      delete  monument[0].reviews[index].monument_id,
      delete  monument[0].reviews[index].user_id
    }
    
    res.status(200).json({ ms:monument[0],isfav });
    
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Error classifying image' });
  }
});







// recommendation
// the function that call the flask api and send the mount to and get data 
async function getRecommendations(monument) {
  try {
    const response = await axios.get('http://localhost:5000/recommend', {
      params: {
        monument: monument
      }
    });
    return response.data.recommended_GP;
  } catch (error) {
    console.error('Error:', error.response.data);
    throw error;
  }
}

// making an api to use the the fun 
  router.get('/recommend', async (req, res) => {
    const monument = req.query.monument;
    try {
      const response = await axios.get('http://localhost:5000/recommend', {
        params: {
          monument: monument
        }
      });
      // making a query to return an monument full data 
      const query = util.promisify(conn.query).bind(conn);
      const mixedMonument=[]
       const recommendedMounmentName=response.data.recommended_GP
      for(let x=0;x<recommendedMounmentName.length;x++){
        const monument = await query(`select * from monument where name=? or name LIKE '%${recommendedMounmentName[x]}%'`,recommendedMounmentName[x]);
        monument.map((monument) => {monument.image_url = "http://" + req.hostname + ":3000/" + monument.image_url;});
        //show if favourite or not 
        let monumentFavourites = [];
            for (let index = 0; index < monument.length; index++) {
              let isfav=0 ;
             const isFavQuery = await query(`select * from favourite where monument_id =?`,monument[index].id);
             if(isFavQuery[0]){
               isfav=1;}
               monumentFavourites.push(isfav);
             }
            
             let v={ }
             for (let  index = 0; index < monument.length; index++) {
              v={monument:monument[index],isFav:monumentFavourites[index]}
              mixedMonument.push(v) ;
             
            }
          }
      res.json(mixedMonument);
    } catch (error) {
    //  console.error('Error:', error.response.data);
    console.log(error)
      res.status(500).json({ error: 'An error occurred while getting recommendations' });
    }
  });
  

module.exports = router ;