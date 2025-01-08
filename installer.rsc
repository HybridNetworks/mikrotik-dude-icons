/system script
add comment="mikrotik-dude-icons pack download script" dont-require-permissions=no name=installer owner=admin policy=ftp,write source="# ==============================\
    ==============================\
    \n# (C) 2011-2025 HybridNetworks Ltd. -- All Rights Reserved\
    \n#\
    \n# ABOUT CONTACT:\
    \n# HybridNetworks Ltd.\
    \n# info@hybridnetworks.com.ar\
    \n# https://www.hybridnetworks.com.ar\
    \n#\
    \n# Use this script only on the configured and supported device.\
    \n# PLEASE do not change, edit or modify any part of this script.\
    \n# PLEASE do not use on devices other than technical support.\
    \n# PLEASE do not remove this notice or your copyright.\
    \n#\
    \n# If you are a developer or consultant and want to incorporate \
    \n# this script into your own products. PLEASE contact us to receive \
    \n# permits under terms and conditions.\
    \n#\
    \n# ============================================================\
    \n\
    \n# Debug mode\
    \n:global dms false;\
    \n\
    \n# Get the directory for Dude\
    \n:local dudeDir ([/system/script/environment/get dudeDirectory value-name=value]);\
    \n\
    \n# Define the directory for images\
    \n:local imageDir (\$dudeDir . \"/files/images/\");\
    \n\
    \n# URL of the file containing the list of images\
    \n:local fileUrl \"https://raw.githubusercontent.com/danielcshn/mikrotik-dude-icons/main/images_list.txt\"\
    \n\
    \n# Fetch the image list from the URL\
    \n:local imgList ([/tool fetch url=\$fileUrl output=user as-value]->\"data\");\
    \n\
    \n# Check if the image list was retrieved successfully\
    \n:if ([:len \$imgList] > 0) do={\
    \n    # Loop through each image in the list\
    \n    :foreach image in=[ :deserialize [:tolf \$imgList] delimiter=\"\\n\" from=dsv options=dsv.plain ] do={\
    \n        # Construct the full URL for each image\
    \n        :local imageUrl (\"https://raw.githubusercontent.com/danielcshn/mikrotik-dude-icons/main/images/\" . \$image);\
    \n        # Fetch the image and save it to the specified directory\
    \n        :local downloadResult ([/tool fetch url=\$imageUrl mode=https dst-path=(\$imageDir . \$image) as-value]->\"status\");\
    \n        # Check if the download was successful\
    \n        :if (\$downloadResult = \"finished\") do={\
    \n            :if (\$dms) do={:log info (\"Download: \" . \$image);};\
    \n        } else={\
    \n            :if (\$dms) do={:log error (\"Error Download: \" . \$image);};\
    \n        }\
    \n    }\
    \n} else={\
    \n    :if (\$dms) do={:log error \"Error: Could not get image list.\";};\
    \n}"