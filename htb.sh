#!/bin/bash

# Prompt for IP address and domain
read -p "Enter the IP address: " ip_address
read -p "Enter the domain: " domain

# Add IP and domain to /etc/hosts
echo "$ip_address $domain" | sudo tee -a /etc/hosts > /dev/null

# Open new tabs in terminal window
xdotool key ctrl+shift+t
sleep 0.5 # wait for the new tab to open
xdotool type --delay 10 "nmap $ip_address -oN quick.txt"
xdotool key Return

xdotool key ctrl+shift+t
sleep 0.5 # wait for the new tab to open
xdotool type --delay 10 "nmap $ip_address -p- -A --min-rate 5000 -oN thorough.txt"
xdotool key Return

xdotool key ctrl+shift+t
sleep 0.5 # wait for the new tab to open
xdotool type --delay 10 "feroxbuster -u http://$domain/ -o dir.txt"
xdotool key Return

xdotool key ctrl+shift+t
sleep 0.5 # wait for the new tab to open
xdotool type --delay 10 "gobuster vhost -u $domain -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt -o sub.txt"
xdotool key Return
