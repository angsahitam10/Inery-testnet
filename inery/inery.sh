#!/bin/bash
clear
merah="\e[31m"
kuning="\e[33m"
hijau="\e[32m"
biru="\e[34m"
UL="\e[4m"
bold="\e[1m"
italic="\e[3m"
reset="\e[m"

# Env Vars
cd $HOME
PATH=""$PATH":"$HOME"/inery-node/inery/bin:"$HOME"/inery-node/inery.setup/master.node"
inerylog=""$HOME"/inery-node/inery.setup/master.node/blockchain/nodine.log"
invalid_input=""$bold""$merah"Invalid input "$REPLY". Please select yes or no\n"$reset""
invalid_format=""$bold""$merah"Format is not correct$reset\n"
format=""$bold""$UL""$hijau""
continue=""$hijau""$bold"Press enter to continue"$reset""
bline="======================================================================="

# Function set_account_name

set_account_name(){

accname=""$bold""$hijau"account name"$reset""
accID="Enter your $accname: $reset"
while true; do
echo "$bline"
read -p "$(printf "$accID""$reset")" name
echo -e "$bline\n"
    if [[ ! "$name" =~ ^[a-z1-5]{2,12}[.]{0,1}[a-z1-5]{2,12}$ ||  ${#name} -gt 12 ]];then
        echo -e ""$name ""$invalid_format""$bold""$merah"Name can have maxiumum of 12 charachters ASCII lowercase a-z, 1-5 and dot character "." but dot can't be at the end of string\n"$reset""
	accID="Please enter your correct $accname: "
    else
	while true; do
        echo -e -n "Is this $accname "$format""$name""$reset" correct? [Y/n]"
        read yn
        case $yn in
            [Yy]* ) printf "\n"; ACC=true; break;;
            [Nn]* ) printf "\n"; ACC=false; break;;
            * ) echo -e "$invalid_input"; echo -e "$bline\n";;
        esac
        done
        if [[ $ACC = true ]]; then
            echo -e "export IneryAccname="$name"" >> $HOME/.bash_profile
            source $HOME/.bash_profile
            break
        else
            accID="Please enter your $accname again: "
        fi
    fi
done

}

# funtion Set pubkey

set_pubkey(){

pubkeyname="$bold""$hijau"public-key"$reset"
publickey="Enter your "$pubkeyname": $reset"
while true; do
echo $bline
read -p "$(printf "$publickey""$reset")" pubkey
echo -e "$bline\n"
    if [[ ! $pubkey =~ ^[INE]{1}[a-zA-Z1-9]{52}$ ]]; then
        echo -e "$bold$pubkeyname $pubkey" "$invalid_format"
        publickey="Please enter your correct $pubkeyname: $reset"
    else
	while true; do
        echo -e -n "Is this $pubkeyname "$format""$pubkey"$reset correct? [Y/n]"
        read yn
        case $yn in
            [Yy]* ) printf "\n"; PUB=true; break;;
            [Nn]* ) printf "\n"; PUB=false; break;;
            * ) echo -e "$invalid_input"; echo -e "$bline\n";;
        esac
        done
        if [ $PUB = true ]; then
            echo -e "export IneryPubkey="$pubkey"" >> $HOME/.bash_profile
            source $HOME/.bash_profile
	    break
        else
	    publickey="Enter your $pubkeyname again: "
        fi
    fi
done

}

# Funtion Set privkey

set_privkey(){

privkeyname="$bold""$hijau"private-key"$reset"
privatekey="Enter your"$hijau" $privkeyname: "
while true; do
echo -e "$bline"
read -p "$(printf "$privatekey""$reset")" privkey
echo -e "$bline\n"
    if [[ ! $privkey =~ ^[5]{1}[a-zA-Z1-9]{50}$ ]]; then
        echo -e "$bold$privkeyname $privkey" "$invalid_format"
        privatekey="Please enter your correct $privkeyname: $reset"
    else
	while true; do
        echo -e -n "Is this $privkeyname "$format""$privkey"$reset correct? [Y/n]"
        read yn
        case $yn in
            [Yy]* ) printf "\n"; PRIV=true; break;;
            [Nn]* ) printf "\n"; PRIV=false; break;;
            * ) echo -e "$invalid_input"; echo -e "$bline\n";;
        esac
        done
        if [[ $PRIV = true ]]; then
            break
	else
	    privatekey="Enter your $privkeyname again: "
        fi
    fi
done

}

set_peers(){

default_ip=$(curl -s ifconfig.me)
ipaddress="$bold""$hijau"ip-address"$reset"
enter_ip="Enter your"$hijau" $ipaddress: "
while true; do
echo -e "$bline\n"
echo -e "$bold""$kuning"INFO: "$reset"Your IP in this machine is: "$bold""$hijau""$default_ip$reset\n"
echo -e "$bline"
read -p "$(printf "$enter_ip""$reset")" address
echo -e "$bline\n"
    if [[ ! $address =~ ^[0-9]{1,3}[.]{1}[0-9]{1,3}[.]{1}[0-9]{1,3}[.]{1}[0-9]{1,3}$ ]]; then
        echo -e "$bold$ipaddress $address" "$invalid_format"
        enter_ip="Please enter your correct $ipaddress: $reset"
    else
	while true; do
        echo -e -n "Is this $ipaddress "$format""$address"$reset correct? [Y/n]"
        read yn
        case $yn in
            [Yy]* ) printf "\n"; ADDR=true; break;;
            [Nn]* ) printf "\n"; ADDR=false; break;;
            * ) echo -e "$invalid_input"; echo -e "$bline\n";;
        esac
        done
        if [[ $ADDR = true ]]; then
            break
	else
	    enter_ip="Enter your $ipaddress again: "
        fi
    fi
done

}
# Import wallet

import_wallet(){
    cd; cline wallet create -n $name --file $name.txt
    cline wallet import -n $name --private-key $privkey
}

# reg_producer

reg_producer(){
    cline wallet unlock -n $IneryAccname --password $(cat $HOME/$IneryAccname.txt)
    cline system regproducer $IneryAccname $IneryPubkey 0.0.0.0:9010
    echo -e ""$kuning""$bold"Reg producer success"
    sleep 0.5
    cline system makeprod approve $IneryAccname $IneryAccname
    echo -e ""$kuning""$bold"Approve producer success"
    sleep 0.5
}

# Set account

install_master_node(){
echo -e "$bold$hijau 1. Set account... $reset"
sleep 1

# S3t account
set_account_name
set_pubkey
set_privkey
set_peers

# Print account setting

echo -e "\n$bline"
echo -e "\t\t\tMaster-node configuration$reset"
echo -e "$bline"
echo -e "Your $accname is: $bold$hijau$name$reset"
echo -e "Your $pubkeyname is: $bold$hijau$pubkey$reset"
echo -e "Your $privkeyname is: $bold$hijau$privkey$reset"
echo -e "Your peers is: $bold$hijau$address:9010$reset"
echo -e "$bline\n"
sleep 2
# Update upgrade

echo -e "$bold$hijau 2. Updating packages... $reset"
sleep 1
sudo apt update && sudo apt upgrade -y

# Install dep

echo -e "$bold$hijau 3. Installing dependencies... $reset"
sleep 1
sudo apt install -y make bzip2 automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev \
autotools-dev libicu-dev python2.7 python2.7-dev python3 python3-dev \
autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev \
libcurl4-gnutls-dev pkg-config patch llvm-7-dev clang-7 vim-common jq libncurses5 ccze git screen

echo -e "$bold$hijau 4. Installing node... $reset"
sleep 1

# Clone repo

cd $HOME
rm -rf inery-*
git clone https://github.com/inery-blockchain/inery-node

# Edit permission and set vars

echo -e "export PATH="$PATH":"$HOME"/inery-node/inery/bin:"$HOME"/inery-node/inery.setup/master.node" >> $HOME/.bash_profile
echo -e "export inerylog="$HOME"/inery-node/inery.setup/master.node/blockchain/nodine.log" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Set config

peers="$address:9010"
sed -i "s/accountName/$name/g;s/publicKey/$pubkey/g;s/privateKey/$privkey/g;s/IP:9010/$peers/g" $HOME/inery-node/inery.setup/tools/config.json

echo -e "$bold$hijau 5. Running master node... $reset"
sleep 1
run_master
# create wallet

echo -e "$bold$hijau 6. Import wallet to local machine... $reset"
sleep 1
import_wallet

echo -e "$bold$hijau 7. Enable firewall... $reset"
sleep 1

# Enable firewall

sudo ufw allow 8888,9010/tcp
sudo ufw allow ssh
sudo ufw limit ssh

# Print

echo -e "\n========================$bold$biru SETUP FINISHED$reset ============================"
echo -e "Source vars environment:$bold$hijau source $HOME/.bash_profile $reset"
echo -e "Check your account name env vars:$bold$hijau echo \$IneryAccname $reset"
echo -e "Check your public-key env vars:$bold$hijau echo \$IneryPubkey $reset"
echo -e "Your wallet password save to:$bold$hijau cat $HOME/\$IneryAccname.txt $reset"
echo -e "Check logs with command:$bold$hijau tail -f \$inerylog | ccze -A $reset"
echo -e "========================$bold$biru SETUP FINISHED$reset ============================\n"
source $HOME/.bash_profile
sleep 2
}

run_master(){
chmod 777 $HOME/inery-node/inery.setup/ine.py
cd $HOME/inery-node/inery.setup
setsid ./ine.py --master >/dev/null 2>&1 &
}

while true; do
# logo

curl -s https://raw.githubusercontent.com/jambulmerah/guide-testnet/main/script/logo.sh | bash

# Menu

PS3='Select an action: '
options=(
"Install master node"
"Check Log"
"Reg/approve as producer"
"Create test token"
"Exit")
select opt in "${options[@]}"
do
case $opt in

"Install master node") # install Node
clear
install_master_node

echo -e -n $continue
read
clear
break;;

"Check Log") # Checklogs
clear
tail -f $inerylog | ccze -A
clear
continue;;

"Reg/approve as producer") # Reg as producer
clear
cd $HOME
source $HOME/.bash_profile
PATH=""$PATH":"$HOME"/inery-node/inery/bin:"$HOME"/inery-node/inery.setup/master.node"
cd $HOME/inery-node/inery.setup/master.node/
./start.sh
if [[ -d $HOME/inery-wallet && $IneryAccname && $IneryPubkey ]]; then
        reg_producer
	echo -e ""$bold""$kuning"\nSuccessfull reg as producer"
	sleep 2
else
        echo -e ""$bold""$merah"No wallet in local machine found"
        echo -e ""$bold""$kuning"First create wallet and set as env vars"
        set_account_name
        set_pubkey
        set_privkey
	import_wallet
	reg_producer
	echo -e ""$bold""$kuning"\nSuccessfull reg as producer"
	sleep 2
fi
echo -e -n $continue
read
clear
break;;

"Create test token") # Create test token
clear
create_test_token(){

    cd $HOME
    rm -f token.wasm token.abi
    cline get code inery.token -c token.wasm -a token.abi --wasm
    echo -e "inery\ninery.token\njambul.inery" >/tmp/acclist
    tail -n 100 $inerylog | grep "signed by" | awk '{printf "\n"$15}' | tail -11 >> /tmp/acclist
    mapfile -t acc_list </tmp/acclist
    cline wallet unlock -n $IneryAccname --password $(cat $IneryAccname.txt)
    cline set code $IneryAccname token.wasm
    echo -e ""$kuning""$bold"Set code success$reset"
    sleep 0.5
    cline set abi $IneryAccname token.abi
    echo -e ""$kuning""$bold"Set abi success$reset"
    create_data=\''["account", "30000.000 TKN", "creating my first tokens"]'\'
    issue_data=\''["account", "1000.000 TKN", "issuong 1000 TKN in circulating supply"]'\'
    transfer_data=\''["account", "test22", "1.000 TKN", "Here you go 1 TKN from account ????"]'\'
    echo
    symbol_name=""$kuning""$bold"Set your token symbol: $reset"
    while read -p "$(printf "$symbol_name")" symbol; do
        if [[ ! $symbol =~ ^[A-Z]{1,7}$ ]]; then
            echo -e ""$kuning"Symbol only with 1-7 UPPERCASE"
            continue
        else
    create_token_data=$(echo -n $create_data | sed "s/account/$IneryAccname/g;s/TKN/$symbol/g")
    issue_token_data=$(echo -n $issue_data | sed "s/account/$IneryAccname/g;s/TKN/$symbol/g")
            tee /tmp/createtoken.sh >/dev/null <<EOF
#!/bin/bash
cline push action inery.token create $(echo -n $create_token_data) -p $IneryAccname
printf "\n$kuning$bold successfull create token symbol $symbol$reset\n"
sleep 2
cline push action inery.token issue $(echo -n $issue_token_data) -p $IneryAccname
echo -e "\n$kuning$bold successfull issuing token$reset\n"
sleep 2
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[0]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[1]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[2]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[3]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[4]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[5]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[6]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[7]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[8]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[9]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[10]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[11]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[12]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
cline push action inery.token transfer $(echo -n $transfer_data | sed "s/account/$IneryAccname/g;s/test22/${acc_list[13]}/g;s/TKN/$symbol/g") -p $IneryAccname
sleep 0.5
EOF
bash /tmp/createtoken.sh
            echo -e "Token succesfully transfered to ${#acc_list[*]} account"
            for list in ${!acc_list[*]}; do
	    printf "%4d: %s\n" $list ${acc_list[$list]}
	    done
            break
        fi
    done
}

cd $HOME
source $HOME/.bash_profile
PATH=""$PATH":"$HOME"/inery-node/inery/bin:"$HOME"/inery-node/inery.setup/master.node"
if [[ -d $HOME/inery-wallet && $IneryAccname && $IneryPubkey ]]; then
    create_test_token
    sleep 2
else
    echo -e ""$bold""$merah"No wallet in local machine found"$reset""
    echo -e ""$bold""$kuning"First create wallet and set as env vars"$reset""
    set_account_name
    set_pubkey
    set_privkey
    import_wallet
    create_test_token
    sleep 2
fi
echo -e -n $continue
read
clear
break;;

"Exit") echo -e "$biru\t GOOD BY";exit;;

*) echo -e ""$bold""$merah"invalid option$REPLY $reset"; continue;

esac
done
done
