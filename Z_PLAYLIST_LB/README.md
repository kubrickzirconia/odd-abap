# Z_PLAYLIST_LB

This project consists of two main components:

1. ZTRACKS_LB: a DDIC to store a list of songs.

2. Z_PLAYLSIT_LB: an RFC enabled function module that can be used to create, read, update, and delete ZTRACKSLB. 

The Z_PLAYLIST_LB function module can be used to perform the CRUD operations on the database, allowing the user to maintain a tracklist.

## Data Dictionary

ZTRACKS_LB can be created in SE11. The image below shows the fields I included in my custom DDIC. I chose to create my own custom data elements and domains for each field.

![](ztracks_lb-ddic.JPG)

## RFC Enabled Function Module

The function module Z_PLAYLIST_LB was created in SE37, and assigned to a function group created specifically for this project. On the attributes tab, the Processing Type must be set to 'Remote-Enabled Module'. This ensures that the function module can be called externally, like an API.

![](createFM.JPG)

#### The Parameters

A second DDIC structure was created for the importing table parameter as the table needed to include a field for the CRUD operations. 

![](rfcddic.JPG)

For the CRUD field, a custom domain and data element, both named ZCRUD, were created:

![](zcruddomain.JPG) ![](zcruddomain1.JPG)

#### The Sourcecode 

IF it_ztracks-crud = 'C'.

IF it_ztracks-crud = 'R'.

IF it_ztracks-crud = 'U'.

IF it_ztracks-crud = 'D'.
