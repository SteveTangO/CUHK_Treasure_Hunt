/*
Module to retrieve the messages between the user logged in and another user

Module Name: Messages
Programmer: Hon Tik TSE
Version: 1.0 (10 May 2020)

Input Parameters:
   contact_id: user_id of the user with whom the conversation is to be viewed

Output Parameters:
   messages in json format
*/
<?php
  
    // messages are sorted in recency, i.e. the more recent the message, the smaller the index in the array
    
    require_once('connectDB.php');
    require_once('userAuthentication.php');
    
    $contact_id = $_GET['contact_id']; // user id of another user
    
    $sql = "SELECT * FROM messages WHERE (sender_id,receiver_id) IN (({$user_id},{$contact_id}),({$contact_id},{$user_id})) ORDER BY message_id DESC LIMIT 100;";
    
    require_once('echo.php');
    
?>
