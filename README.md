# MeetPlanDocker
`docker-compose` for MeetPlan v2

# Deployment (please let me know if it doesn't work - tested on the fly)
1. Clone repository: `git clone https://github.com/MeetPlan/MeetPlanDocker`
2. Run `getdhparam.sh` - `chmod +x getdhparam.sh && ./getdhparam.sh` - this will take a few minutes, do not exit.
3. Replace email and domain in `initcert.sh`
4. Replace volume information in `docker-compose.yml`
5. Replace server information in `default.conf.aftercert` and `default.conf.beforecert`
6. Run `initcert.sh` - `chmod +x initcert.sh && ./initcert.sh`
7. You are ready to go. Start the server using `sudo docker-compose up -d`

Your certificates will renew automatically overtime, so no maintainence is needed.
