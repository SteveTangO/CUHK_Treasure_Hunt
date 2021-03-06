## Backend Usage Guide
by Hon Tik TSE

### Backend Files
file|use|completed
--|--|--
buyRequests.php | retrieve buy requests | Y
favourites.php | retrieve favourites | Y
itemsPosted.php|retrieve items posted | Y
login.php | login.. | Y
manageBuyRequests.php | create/update/delete  buy requests | Y
manageFavourites.php | create/delete favourites | Y
manageItems.php | create/update/delete items | Y
profile.php | retrieve profile | Y
updateProfile.php | make changes to profile | Y
register.php | register user | Y
transactions.php | retrieve transactions/history | Y 
manageTransactions | create/update/delete transactions | Y (message left)
updateProfile.php | updateProfile | Y
updateReputation.php | updateReputation | Y
usernameExists.php | check whether username exists | Y
search.php | search for items (by name) | Y
verificationMail.php | send verification email | Y
contactList.php | retrieve a user's contact list | Y
messages.php | retrieve a user's chat history with another particular user | Y
uploadImage.php | upload an image | Y
checkProfile.php | check another user's profile | Y
filter.php | filter search results using a tag (can only filter based on 1 tag at a time) | Y
tags.php | return tags of an item given item_id (used in item details?) | Y
postTags.php | post the tags of an item | Y

### Important Note: Some of the files can only be used after login cause user Authentication is required.

### Guides to using using these files:
1. Use the static methods get/post to call these files (except for login)
2. Look into the file. If you see $_GET use get, if you see $_POST use post
3. provide the path to the get/post methods: "/data/<filename, including .php>"
4. Look into the files to see what query parameters u need
    - See what is following $_GET and $_Post
5. For get, query should be in the following format: "?parameter1=value1&parameter2=value2"
6. For post, query should be an associative array: {"parameter1":"value1", "parameter2" : "value2"}
7. For post, even if the value is number, wrap it with a ""
8. The return data for get will be a json encoded array
    - Each element of the array will be an associative array
    - Look at the php files to find out what are the keys (Look at what's following SELECT in $sql)
    - Use json.decode(response.body) to retrieve the array of associative arrays
    - Access the values as you would do normally: arr[0]['key']
9. The return data for post will be either 'success' or 'fail' (not encoded)
