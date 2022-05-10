# MeetPlan installation on a Linux virtual machine
WARNING: MeetPlan is designed for only one school. You cannot manage multiple schools on same Docker container, however, you can deploy multiple Docker instances on the same server & modify the NGINX configuration.

So, you decided to install MeetPlan to your server. Here is the official documentation, written as simply as possible.

## Steps:
### 1. Fork repositories (for modification - not necessary)
Fork all of the following repositories (you have to be logged into GitHub to do that):
- [MeetPlanBackend](https://github.com/MeetPlan/MeetPlanBackend) - not necessary if you don't want to change assets, though it's recommended to change the assets
- [MeetPlanFrontend](https://github.com/MeetPlan/MeetPlanFrontend) - not necessary if you don't want to change assets

GitHub Packages & GitHub Actions tokens are so well made, they [don't allow forked repos to have write access](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token). Instead, we have to use painstainking way of using Git, but don't worry, all commands are going to be explained.

First, go to a "Plus" icon in top right. Click it & select "New repository". It should bring you to the following page:
![image](https://user-images.githubusercontent.com/52399966/167313596-f55b0afb-bb90-40fc-a5fa-cf1806f8e79c.png)

Name the repository as "MeetPlanBackend" and give it a custom description. Do not initialize anything - no README, no gitignore and no license. The repository may be private if you wish so, but note that GitHub will limit your GitHub Actions & Packages quota, which can be quite big for MeetPlanFrontend (which we don't recommend forking anyways).

Click "Create repository" and you are greeted with an empty repository.
![image](https://user-images.githubusercontent.com/52399966/167313685-35877891-a874-40ac-8b34-f849a5c5e2d6.png)

Go to repository settings, go to "Actions" tab and select "General". Scroll down to the setting, called "Workflow permissions". Select "Read and write permissions" instead of "Read repository contents permission" and click "Save". You have enabled automatic building and pushing the Docker containers to the GitHub Container Registry.

[Install Git](https://git-scm.com/downloads) for your system. Don't forget to add it to PATH if installer asks you.

Now, let's clone MeetPlan's source code. You have to open the terminal to use this command (`cmd` or `PowerShell` on Windows).
```sh
git clone https://github.com/MeetPlan/MeetPlanBackend
```

Now, move into the cloned directory:
```sh
cd MeetPlanBackend
```

Add your fork as a remote:
```sh
git remote add myfork <my fork URL>
```
Example:
```sh
git remote add myfork https://github.com/mytja/MeetPlanBackend
```

Now, push all the code to the fork.
```sh
git push myfork
```

And, that's it. Repeat this process for other repositories (if you wish so).

### 2. Modify the backend to contain different assets (skip if you didn't fork the backend)
MeetPlan by default provides our logos for certificate generation. You can change that to your school logotypes & banners for a better experience.

Go back to "Code" section of your fork (of MeetPlanBackend)
![image](https://user-images.githubusercontent.com/52399966/167299972-40437c65-1a72-4798-a042-d6af7cadb55a.png)
*This is an old image, where I really forked it, but the principle stays the same*

Now click `.` (dot). It should bring you to online instance of Visual Studio Code.

Open the `icons` folder in the navigator (should be positioned on the left). Reupload all of the files with your own by dropping your files into `icons` folder in the Visual Studio Code window. Be sure that you replace all old files with new ones.
Filenames MUST be same. MeetPlan logo ususally means school logo or a banner and should be replaced by your school's one.

Once you have uploaded it, the files should be green.

![image](https://user-images.githubusercontent.com/52399966/167306191-eff9ed28-e7d9-4770-9e6a-c5dae52eac4b.png)

Click on the button that has number `2` on my picture. It's also called `Git button`.

You should see this

![image](https://user-images.githubusercontent.com/52399966/167306268-120023d5-58de-4964-9c68-ad35b8a9fa2e.png)

Hover over changes tab. You'll see 2 buttons pop up - one is "Discard all changes" and the other one is "Stage all changes". Click on the "Stage all changes" button. You have now staged the files.

![image](https://user-images.githubusercontent.com/52399966/167306379-f8861bfe-0e52-4c2a-97f8-9a4a5c010e6e.png)

Type in a commit message, let's say `replace old logos with new ones` & click the checkmark button at the top (if you hover over it, it should say "Commit and Push").

![image](https://user-images.githubusercontent.com/52399966/167306437-40123df4-9db7-466b-870b-9397396cf048.png)

Congratulations. You have successfully commited & pushed your files to your fork.

Now, go back to your repository. Open the "Actions" tab. You should see a running action. Wait for approx. 5 minutes. You should see a green checkmark.
![image](https://user-images.githubusercontent.com/52399966/167306504-26877085-35e4-4f5a-9039-af9f27f20672.png)
*This is an old image, where I really forked it, but the principle stays the same. GitHub Action is running - wait until green checkmark appears*

### 3. Virtual Machine (VM) setup
So, here we are, at the most important part - hosting the service. The setup is a little bit tricky, especially for Docker, but don't worry, we'll get all through it.

#### 3.1. Select your VPS (Virtual Private Server aka. Virtual Machine aka. Server) provider
This step is crucial. As I have experience on how this works within Slovenia, I'll describe the process within Slovenia.

Schools in Slovenia generally have four options:
- Choose a Slovenian VPS hosted for free by [Arnes](https://www.arnes.si). Each school that's rolled into Arnes's network gets sufficient system resources for running MeetPlan. This service is called [Arnes SPM](https://spm.arnes.si/) (Strežnik po meri). I have never tried this, as I don't have sufficient permissions in the [Arnes network](https://aai.arnes.si), so support for this is limited, but it should not differ too much from other solutions. Arnes offers you really nice support if you get stuck anywhere. This solution is definetely most recommended.
- Choose a VPS hosted for free by [GRNET](https://grnet.gr/). Each school that's rolled into Arnes's network gets sufficient system resources for running MeetPlan. This service is called [~okeanos global Cyclades](https://cyclades.okeanos-global.grnet.gr/ui/). I have sufficient permissions in the [Arnes network](https://aai.arnes.si), so this method is fully supported. But beware, all servers expire after 6 months, which is really impractical if you want it to be reliable. THERE IS NO WAY OF RECOVERING ANYTHING AFTER THE SERVER HAS EXPIRED. YOU CAN CONTANCT THE SUPPORT, BUT THEY WILL GIVE YOU A VERY LIMITED TIME PERIOD OF ACCESSING THE SERVER. Arnes SPM servers on the other hand, I think they don't expire. Okeanos servers are running very outdated Linux images and internet connection to Greece (where these servers are hosted) is very poor and slow. Not recommended for serious use, but for testing, definetely recommended. I will be using them in my tutorial, as this is the only one, I have access to.
- Self-host it within the school on school's own servers. This generally requires a lot of administration and is recommended only for schools with bigger needs of controlling their servers and possibly limiting the access to their internal network.
- Choose a public VPS provider, like [Microsoft Azure](https://azure.microsoft.com/en-us/), [Google Cloud Platform](https://cloud.google.com/), [Amazon Web Services](https://aws.amazon.com/), [DigitalOcean](https://www.digitalocean.com/)... DigitalOcean is recommended for small schools, primary schools and some middle schools, which don't have as much students. It's the cheapest. If you need a little bit more control, I'd go with other services. This is not recommended and should be your last resort as it's FULLY PAID MONTHY OR ANNUALY, while for other services you don't need to pay anything.

Once you have selected your VPS provider, head over to step 3.2.

#### 3.2. Create a new virtual machine
Now, the important part. Creating the actual server/virtual machine. This is really important, so follow it carefully.

##### 3.2.1. Generate a new keypair
WARNING: Though it's not recommended to use passwords for server auth, I do recommend them if you pick a really long one, randomly generated, that nobody should be able to guess. It's always better to generate a keypair and use Public-Private key authentication instead of password authentication, but if the service doesn't offer you this option, you can generate a really long password (like 30+ random characters). If you want, you can skip this part. If you don't know if your service supports keypairs, contact support and they will tell you how to enable it on your VM. 

Once you are logged in, you should head over to the key tab. This is really important, so make sure to not mess it up. It should look something like this:

![image](https://user-images.githubusercontent.com/52399966/167488609-3778c69c-42be-41ee-b89d-7ac7fd767e1e.png)

Click "New Keypair". It should look something like this:

![image](https://user-images.githubusercontent.com/52399966/167488698-2bb5c949-8455-4c03-86dc-e178fd2faee5.png)

In ~okeanos global, you can simply generate a new keypair. Just click the "generate new" button in top right corner. You should see something like this:

![image](https://user-images.githubusercontent.com/52399966/167489439-2431513c-bb3a-4683-9629-2bb87f640f9a.png)

DOWNLOAD THE PRIVATE KEY. DON'T FORGET TO DOWNLOAD IT. IT'LL HAVE HUGE CONSEQUENCES LATER. BACKUP THE KEY. BACK IT UP IN THE CLOUD AND ON DIFFERENT HARDWARE (USB keys...)

The downloaded file MUST BE in ".pem" format (with or without an file extension). Once you have successfully backed up the key, click close and head over to virtual machines tab. Click on "New Machine". A new popup should appear.

##### 3.2.2. Create a VM configuation
You should see the following:

![image](https://user-images.githubusercontent.com/52399966/167490100-44885958-309f-4989-96b5-05d2f34d6f20.png)

Always stick to system images, as these are stable and tested on this hardware. If you are using ~okeanos global, I recommend Ubuntu 16.04 LTS Linux, as it's the simplest to install Docker, but on any other VPS provider, I'd rather recommend Debian Linux, as it's more lightweight. Ubuntu directly inherits packages from Debian, so the commands should work for both operating systems.

I'll select Ubuntu 16.04 LTS. Note that this is really outdated and unsupported image. Update the image as soon as possible. Once you have selected the desired operating system, click "Next".

Minimum hardware requirements for MeetPlan are:
- Linux-based operating system
- 1 (v)CPU core
- 0.5 GB RAM
- Around 8GB for whole OS installation

I however, recommend "2 vCPUs" and "2GB of RAM". You should pick "40GB of disk space". You MUST select an IP address. If you are not sure if IP address is already used by another machine, just create a new one. Click "next". Name the server as you wish. You must also select the public SSH key, generated beforehand.

![image](https://user-images.githubusercontent.com/52399966/167491384-def45e4e-0ca9-49c3-9bca-00544f5d91bb.png)

Following is my final configuration:

![image](https://user-images.githubusercontent.com/52399966/167491468-95c9a6ab-3005-4ba2-864b-1f539827852b.png)

Once you are satisfied with your config, click "create machine". It should prompt you to save the password. Save it somewhere, you will need it. Wait for the machine to build and afterwards, you should be able to connect to the virtual machine by SSH software.

Do you remember the key we downloaded from part 3.2.1.? This tutorial is written on Linux, so now you'll have to do the following. Open the terminal within the folder in which the downloaded key is. Do `chmod 400 <your key filename>`. Afterwards, you should be able to connect to the server using `SSH`. Do `ssh -i <your key filename> user@<ip address to the server>`. You should accept everything, and afterwards, when you see the following on your screen (or something similar), you know you are in the server.
```sh
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-109-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

254 packages can be updated.
180 updates are security updates.


user@snf-58132:~$
```

<!---
Now, remember that password, I asked you to save earlier. Now do the following command `sudo usermod -aG sudo user`. It will ask you for this password. You should enter it and that's it.

Now, open the SSH config file by using `sudo nano /etc/ssh/sshd_config`. Nano is just a simple text editor and I'm sure you'll figure out how you move within it 😉.

Head over and replace these lines (they might not be all at the same spot - grouped together):
```
#PasswordAuthentication yes
UsePAM yes

PermitRootLogin prohibit-password
```
to this:
```
PasswordAuthentication no
UsePAM no
PermitRootLogin no
PermitRootLogin prohibit-password
```

Write it out using CTRL+O and enter button, followed by CTRL+X.

Reload the SSH daemon using this command: `sudo systemctl reload ssh`

-->

##### 3.2.3. Subdomain setup
Let's say you already own a domain. If not, you can get one for free at [dot.tk](https://dot.tk). Open up the configuration for your domain. Go to "DNS management" or something similar. It should look something like this on dot.tk:

![image](https://user-images.githubusercontent.com/52399966/167690989-751cb5f1-568a-4079-8d92-51b0bb3206c1.png)

Head over to "Add records" section. In the name text box, you enter the subdomain name, for example "meetplan". Set "Type" to A and "TTL" to 3600. "Target" should be your server's IP address. My configuration is following:

![image](https://user-images.githubusercontent.com/52399966/167691584-540a5637-de88-4f31-aa11-f268650457a6.png)

Click on "Save changes" and boom, you are done with domain setup. Pretty easy, right?

##### 3.2.4. Docker & docker-compose setup
Let's head back to the server. You should still be connected to it using SSH, otherwise simply connect to it as described above.

Firstly, let's update the `apt` repositories. Do the following: `sudo apt update`. It will prompt you for a password.

Now, install `haveged`. This makes sure that your system entropy is always high, which is mandatory for Docker. Install it using following command: `sudo apt install haveged`.

Execute following commands, which install Docker and docker-compose.

Ubuntu:
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker version is $(docker --version)"
echo "docker-compose version is $(docker-compose --version)"
```

Debian:
```sh
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker version is $(docker --version)"
echo "docker-compose version is $(docker-compose --version)"
```

It might take a while, so be patient. If you get an output of both versions, you can be sure the Docker has been installed to your system and you can continue to the next chapter.

##### 3.2.5. MeetPlanDocker
Great, this step should be the shortest of them all.

Execute the following command: `git clone https://github.com/MeetPlan/MeetPlanDocker`

Head into the freshly cloned repository by using this command: `cd MeetPlanDocker`

We'll have to modify the Docker files. First, we'll open the `initcert.sh` file with `nano`. Use the following command: `nano initcert.sh`.

Head over to line 3. Change the email (`test@example.org`) to your personal/work/school email and the domain (`example.org`) to your subdomain, which is in my case `meetplan.meetplan.ml`. Be sure you configure this correctly otherwise the SSL certificate generation won't work correctly.

Write the file out with the following sequence: CTRL+O -> Enter -> CTRL+X

Now, let's open up the `docker-compose.yml` file. Use nano to open it: `nano docker-compose.yml`.

Go to the end of the file, where you should see following:
https://github.com/MeetPlan/MeetPlanDocker/blob/5fae73fa6357f4cd6fa17bcd402fff2a13c30e54/docker-compose.yml#L70-L75

Change `<yourusername>` to your Linux system username (if you are using Okeanos, it's either `user` (for Ubuntu) or `debian` (for Debian)).

Head a little bit up in the file until you find something like this:
https://github.com/MeetPlan/MeetPlanDocker/blob/cf005a3599dc53808635958373df5e6003766eaf/docker-compose.yml#L42-L45

You have to change the `ghcr.io/meetplan/backend` to `ghcr.io/<your github fork username>/backend`, in my case it's `ghcr.io/mytja/backend`.

That's it. Write out the file as described a few lines above and you are good to go.

Now, all you have to do is to execute the following. These commands will install Let's Encrypt SSL certificates (which are fully free of charge, but you can donate anytime - [Let's Encrypt donation link](https://letsencrypt.org/donate), [EFF donation link](https://eff.org/donate-le)) and all the necessary dependencies for it.
```sh
chmod +x getdhparam.sh
chmod +x initcert.sh
./getdhparam.sh
./initcert.sh
sudo docker-compose down
```

##### 3.2.6. Change nginx configuration.
Open the file `default.conf` using `nano` - `nano default.conf`.

Replace ALL the mentions of `example.com` with your domain name, for example `meetplan.meetplan.ml`.

There should be 4 lines that contain this domain name, two `server_name` lines, one `ssl_certificate` line and one `ssl_certificate_key` line.

Final config should be something like this:
```
server {
    listen 80;
    listen [::]:80;
    server_name meetplan.meetplan.ml;

    location ~ /.well-known/acme-challenge {
        allow all;
        root /var/www/html;
    }

    location / {
        rewrite ^ https://$host$request_uri? permanent;
    }
}

server {
   listen 443 ssl http2;
   listen [::]:443 ssl http2;
   server_name meetplan.meetplan.ml;

   server_tokens off;

   ssl_certificate /etc/letsencrypt/live/meetplan.meetplan.ml/fullchain.pem;
   ssl_certificate_key /etc/letsencrypt/live/meetplan.meetplan.ml/privkey.pem;

   ssl_buffer_size 8k;

   ssl_dhparam /etc/ssl/certs/dhparam-2048.pem;

   ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
   ssl_prefer_server_ciphers on;

   ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

   ssl_ecdh_curve secp384r1;
   ssl_session_tickets off;

   ssl_stapling on;
   ssl_stapling_verify on;
   resolver 8.8.8.8;

   client_max_body_size 250M;

   location / {
      proxy_pass http://frontend:3000;
   }

   location /api/ {
      proxy_pass http://backend/;
   }

   root /var/www/html;
   index index.html index.htm index.nginx-debian.html;
}
```

Once you are done, write out file using CTRL+O -> Enter -> CTRL+X keystrokes.

##### 3.2.7. Running the Docker containers.
Running is as simple as one command. If there are any errors, just exit the command (using CTRL+C) and rerun it. If that doesn't help, try to shutdown Docker containers using `sudo docker-compose down`
```sh
sudo docker-compose up
```

First run should be with above command (test run command). Once everything is working, press CTRL+C and wait for Docker to shut down all the containers. After that, you can truly deploy everything. Everything will be running in background using this command:
```sh
sudo docker-compose up -d
```

Now, you can view the logs using `sudo docker-compose logs`, view running containers using `sudo docker-compose ps` and shut down the containers using `sudo docker-compose down`.


Thank you for selecting MeetPlan and wish you a very good experience with it. If you have any problems, please contact me in the [GitHub repo](https://github.com/MeetPlan/MeetPlanDocker) in the "Issues" section. I will be happy to assist.
