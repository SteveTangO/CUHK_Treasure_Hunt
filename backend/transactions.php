// need to test correctness

<?php

    require_once("connectDB.php");
    require_once("userAuthentication.php");

    $type = $_GET["type"]; // received "sell" or "buy"
    $status = $_GET["status"]; // 1 for history, 0 for transactions
    if (type === null || $status === null){
        echo "fail";
        die();
    }
    
    $id = $type == "sell"? "seller_id":"buyer_id";
    $condition;
    if ($status == '0'){ // transactions in progress
        $condition = "t.status_s + t.status_b < 2";
    }
    else { // $status == '1', history
        $condition = "t.status_s = 1 AND t.status_b = 1";
    }
    
     
    $sql = "SELECT u1.username AS seller, u2.username AS buyer, i.name,t.price, t.quantity, t.transaction_id,t.status_s,t.status_b,t.create_time,i.image FROM transactions t JOIN items i USING (item_id) JOIN users u1 ON t.seller_id = u1.user_id JOIN users u2 ON t.buyer_id = u2.user_id WHERE t.{$id} = {$user_id} AND {$condition} ORDER BY t.create_time DESC";
    
    require_once("echo.php");

?>
