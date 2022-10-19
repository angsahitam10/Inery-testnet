# Daftar dulu di websitenya inery. Cara daftar langsung aja cek disini ya :
https://github.com/bangpateng/inery/blob/main/cara-register-testnet.md


# Inery testnet master node guide installation

## Official Links
- [Official Docs](https://docs.inery.io/)
- [Inery Official Website](https://inery.io/)
- [Inery testnet dashboard](https://testnet.inery.io/dashboard)
- [Inery testnet explorer](https://explorer.inery.io)

## 1. Auto installation 
```
wget -O inery.sh https://raw.githubusercontent.com/jambulmerah/guide-testnet/main/inery/inery.sh && bash inery.sh
```

## 2. Next Step 
Klik enter dan klik nomor 5 
Lalu langkah selanjutnya adalah ctrl+c
```
cd
```

### Post installation
```
source $HOME/.bash_profile
```

## 3. Update peer
1. Edit Jumlah Maximal Client
```
cd inery-node/inery.setup/master.node/blockchain/config/
```
```
nano config.ini
```
Cari Kata "Max-Client = 25" (Ganti Menjadi 100) Lalu Simpan CTRL X Y ENTER



2. Stop Node Kalian Terlebih Dahulu
```
cd
cd inery-node/inery.setup/master.node/
```
```
./stop.sh
```

<p align="center">
  <img height="auto" height="auto" src="https://user-images.githubusercontent.com/38981255/196684866-002b9a7c-ec0f-4b94-82d7-fb41528b7930.png">
</p>

3. Tambahkan Peer Address Dengan Perintah
```
nano start.sh
```
Masukan Semua Peer Ini Lihat Gambar Taro di Garis Merah, Peer 3 Yang Ada Bawaannya Jangan di Apus



```
--p2p-peer-address 5.189.138.167:9010 \
--p2p-peer-address 38.242.234.139:9010 \
--p2p-peer-address 86.48.0.180:9010 \
--p2p-peer-address 185.169.252.86:9010 \
--p2p-peer-address 185.207.250.86:9010 \
--p2p-peer-address 38.242.130.28:9010 \
--p2p-peer-address 95.217.134.209:9010 \
--p2p-peer-address 78.46.123.82:9010 \
--p2p-peer-address 161.97.153.16:9010 \
--p2p-peer-address 38.242.154.67:9010 \
--p2p-peer-address 45.10.154.235:9010 \
--p2p-peer-address 45.84.138.8:9010 \
--p2p-peer-address 45.84.138.118:9010 \
--p2p-peer-address 38.242.248.157:9010 \
--p2p-peer-address 45.84.138.209:9010 \
--p2p-peer-address 95.217.236.223:9010 \
--p2p-peer-address 86.48.2.195:9010 \
--p2p-peer-address 135.181.254.255:9010 \
--p2p-peer-address 5.161.118.114:9010 \
--p2p-peer-address 78.47.159.172:9010 \
--p2p-peer-address 45.10.154.239:9010 \
--p2p-peer-address 45.84.138.9:9010 \
--p2p-peer-address 194.163.172.119:9010 \
--p2p-peer-address 45.84.138.119:9010 \
--p2p-peer-address 45.84.138.153:9010 \
--p2p-peer-address 130.185.118.73:9010 \
--p2p-peer-address 45.84.138.247:9010 \
--p2p-peer-address 185.202.238.240:9010 \
--p2p-peer-address 194.163.161.151:9010 \
--p2p-peer-address 65.109.15.147:9010 \
--p2p-peer-address 80.65.211.208:9010 \
--p2p-peer-address 149.102.140.38:9010 \
--p2p-peer-address 38.242.149.97:9010 \
--p2p-peer-address 38.242.156.49:9010 \
--p2p-peer-address 78.187.25.69:9010 \
--p2p-peer-address 212.68.44.36:9010 \
--p2p-peer-address 38.242.159.125:9010 \
--p2p-peer-address 77.92.132.67:9010 \
--p2p-peer-address 20.213.8.11:9010 \
--p2p-peer-address 74.208.142.87:9010 \
--p2p-peer-address 38.242.235.150:9010 \
--p2p-peer-address 65.108.82.31:9010 \
--p2p-peer-address 10.182.0.15:9010 \
--p2p-peer-address 185.249.225.183:9010 \
--p2p-peer-address 167.235.141.121:9010 \
--p2p-peer-address 194.163.162.47:9010 \
--p2p-peer-address 88.198.164.163:9010 \
--p2p-peer-address 193.46.243.16:9010 \
--p2p-peer-address 38.242.159.140:9010 \
--p2p-peer-address 149.102.143.144:9010 \
--p2p-peer-address 161.97.169.27:9010 \
--p2p-peer-address 38.242.219.100:9010 \
--p2p-peer-address bis.blockchain-servers.world \
--p2p-peer-address 193.111.198.52 \
--p2p-peer-address 62.210.245.223 \
--p2p-peer-address 185.144.99.30 \
--p2p-peer-address 38.242.153.15 \
--p2p-peer-address 192.46.226.189 \
--p2p-peer-address 194.5.152.187 \
```

Simpan CTRL X Y ENTER

## 4. Checklog
```
tail -f $HOME/inery-node/inery.setup/master.node/blockchain/nodine.log
```

- First your master node will start fully synchronizing blocks. you will see like this ( Kalian akan melihat seperti ini setelah cek log ) 

![img](./img/sync_true.jpg)

- If the block is fully synced you will see something like this ( Kalian akan melihat seperti ini setelah semua block sync ) 

![img](./img/sync_false.jpg)

Setelah block sync, masuk ke tahap dan step berikutnya

## 5. Reg master node as producer block
After the block is fully synced, continue to register as a block producer
- Start master node
command:
```
cd $HOME/inery-node/inery.setup/master.node
./start.sh
```
>NOTE don't do this before the block is fully synced

- Unlock wallet
command:
```
cline wallet unlock -n $IneryAccname --password $(cat $IneryAccname.txt)
```
- Reg producer
```
cline system regproducer $IneryAccname $IneryPubkey 0.0.0.0:9010
```
- Approve as producer
```
cline system makeprod approve $IneryAccname $IneryAccname
```
After the reg producer transaction is successful, now your node starts to get a share of producing blocks
- Check logs again
```
tail -f $inerylog | ccze -A | grep $IneryAccname
```
after a few minutes you will see logs like this

![img](./img/block_produced.jpg)

## 6. Usefull command
1. Checklog
```
tail -f $HOME/inery-node/inery.setup/master.node/blockchain/nodine.log
```

2. Check saldo wallet
```
cline get currency balance inery.token <ACCOUNT_NAME>
```
Contoh
```
cline get currency balance inery.token blackswan
```

3. Unlock wallet
```
cline wallet unlock -n <nama wallet> --password <cari di file.txt>
```
Contoh
``` 
cline wallet unlock -n wallet --password PW5JYZtgtNQBcJHpDppbqp4djbKRBD65xNMFcjHkMXPsawaweae
``` 
