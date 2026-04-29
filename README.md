> [!CAUTION]
> I DO NOT CONDONE PIRACY. ONLY USE THIS TOOL TO DOWNLOAD GAMES YOU ALREADY OWN.

## RomFetch
This is a simple ROM downloader for RetroPie. It fetches ROMs from [this repo](https://github.com/Cyborg-Taco/Rom-Collection).

## Installation
First, cd into your RetroPie menu:
```
  cd RetroPie/retropiemenu
```
Download the script:
```
  wget https://raw.githubusercontent.com/Cyborg-Taco/romfetch/refs/heads/main/romfetch.sh
```
Make it executable:
```
  chmod +x romfetch.sh
```


## Usage
First, run it. After reloading EmulationStation, you should see an option called **romfetch**. Just launch that.

You can also run it from the terminal in the `retropiemenu` directory by typing:
```
  sudo ./romfetch.sh
```


The first time you run it, you should see a screen like this:  
<img width="575" height="315" alt="image" src="https://github.com/user-attachments/assets/bb06ae03-39aa-4fa5-bf98-246ae0c5eda3" />

Select **Yes** to download the list of ROMs.

You will then see this screen:  
<img width="692" height="400" alt="image" src="https://github.com/user-attachments/assets/10cc764b-e8bc-4feb-81fa-2fa91c716edd" />

Using the **Browse by System** and search functions, select your desired games, then select **Download Selected ROMs**. Use **Update ROM Database** to download the latest ROM list.

## Getting Games Added
If there is a game you would like to be added, please see the [ROM Collection repo](https://github.com/Cyborg-Taco/Rom-Collection).
