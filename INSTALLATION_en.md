# MeetPlan installation on a Linux virtual machine
WARNING: MeetPlan is designed for only one school. You cannot manage multiple schools on same Docker container, however, you can deploy multiple Docker instances on the same server & modify the NGINX configuration.

So, you decided to install MeetPlan to your server. Here is the official documentation, written as simply as possible.

## Steps:
### 1. Fork repositories (for modification - not necessary)
Fork all of the following repositories (you have to be logged into GitHub to do that):
- [MeetPlanBackend](https://github.com/MeetPlan/MeetPlanBackend) - not necessary if you don't want to change assets, though it's recommended to change the assets
- [MeetPlanFrontend](https://github.com/MeetPlan/MeetPlanFrontend) - not necessary if you don't want to change assets
- [MeetPlanDocker](https://github.com/MeetPlan/MeetPlanDocker) - not necessary if you want to modify the configuration on server

![image](https://user-images.githubusercontent.com/52399966/167299591-fe537595-1cd7-4578-b71a-7fa469eb4459.png)
*Fork button*

It should bring you to following page:
![image](https://user-images.githubusercontent.com/52399966/167299664-8fbaa5e5-54b2-4661-bc67-c9e99b5c2a6f.png)

Select the owner and click "Create fork". Repeat this process for all of the repositories mentioned above.

### 2. Enable GitHub Actions on forked repositories
Select "Actions" on your forked repository and click "I understand my workflows, go ahead and enable them".
This will enable GitHub Actions on this fork and thus enable automatic building and publishing to GitHub Container Registry, so that you don't have to do it manually.
Repeat this process for all of the forked repositories.

![image](https://user-images.githubusercontent.com/52399966/167299752-7f48069d-3ac3-4057-b80a-3b24e8491c60.png)

### 3. Modify the backend to contain different assets (skip if you didn't fork the backend)
MeetPlan by default provides our logos for certificate generation. You can change that to your school logotypes & banners for a better experience.

Go back to "Code" section of your fork (of MeetPlanBackend)
![image](https://user-images.githubusercontent.com/52399966/167299972-40437c65-1a72-4798-a042-d6af7cadb55a.png)

Now click `.` (dot). It should bring you to online instance of Visual Studio Code.

Open the `icons` folder in the navigator (should be positioned on the left). Reupload all of the files with your own. Be sure that you replace all old files with new ones.
Filenames MUST be same. MeetPlan logo ususally means school logo or a banner and should be replaced by your school's one.
