#!/bin/bash
#  GVL-BPA-setup.sh
#  
#  Copyright 2014 Simon <simon@hyperion>
#  
#   A shell script to run the setup for BPA tutorials on the GVL platform.
#   You'll need at least a medium instance of the GVL image.
#   The GVL version needs to be 2.19 or greater. (It's only been tested on 2.19)

#   Copy this script to the home directory of the ubuntu user.
#   and run it!

#   The script will:
#       *   Install the GVL command line utilities and create a user called "researcher"
#           (You'll need to give the researcher user a password)
#       *   Downloads the BPA workshop deployment script
#       *   Sets up suitable folder structures in the /mnt/galaxy/export directory
#       *   Creates symlinks to those folders from the researcher users home.
#       *   Runs the BPA deployment script

#   The person doing the workshop will need to log in to the server using the 
#   researcher username with the password used at setup time.

#git clone the GVL command line utilities and set them up

echo "Getting GVL command line utilities."

git clone https://github.com/claresloggett/gvl_commandline_utilities.git

if [ "$?" -ne "0" ]; then
    echo "Git clone of GVL command line utilities failed."
    exit 1
fi

cd gvl_commandline_utilities

./run_all.sh

if [ "$?" -ne "0" ]; then
    echo "GVL command line utilities installation failed."
    exit 1
fi

#Download the BPA tutorial deployment script

echo "Getting the BPA tutorial deployment script"

wget "https://github.com/nathanhaigh/ngs_workshop/raw/master/workshop_deployment/NGS_workshop_deployment.sh"

if [ "$?" -ne "0" ]; then
    echo "Download of BPA setup script failed."
    exit 1
fi


#Setup appropriate folder structure.

echo "Setting up appropriate folder structure"

cd /mnt

mkdir -p galaxy/export/NGS_workshop

sudo ln -s galaxy/export/NGS_workshop .

sudo chown -R ubuntu:ubuntu NGS_workshop

cd

sudo mkdir /home/researcher/Desktop

sudo chown -R researcher:researcher /home/researcher/Desktop



#Run the BPA deployment script

echo "Running the BPA deployment script"

bash NGS_workshop_deployment.sh -t researcher
