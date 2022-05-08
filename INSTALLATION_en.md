# MeetPlan installation on a Linux virtual machine
WARNING: MeetPlan is designed for only one school. You cannot manage multiple schools on same Docker container, however, you can deploy multiple Docker instances on the same server & modify the NGINX configuration.

So, you decided to install MeetPlan to your server. Here is the official documentation, written as simply as possible.

## Steps:
### 1. Fork repositories (for modification - not necessary)
Fork all of the following repositories (you have to be logged into GitHub to do that):
- [MeetPlanBackend](https://github.com/MeetPlan/MeetPlanBackend) - not necessary if you don't want to change assets, though it's recommended to change the assets
- [MeetPlanFrontend](https://github.com/MeetPlan/MeetPlanFrontend) - not necessary if you don't want to change assets
- [MeetPlanDocker](https://github.com/MeetPlan/MeetPlanDocker) - not necessary if you want to modify the configuration on server

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

### 3. Modify the Docker configuration for your own repository (if you forked the repository)

