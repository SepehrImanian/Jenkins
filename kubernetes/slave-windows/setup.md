## Dockerfile

https://github.com/docker-library/docker/tree/master/24/windows

## ssh-agent

https://github.com/jenkinsci/docker-ssh-agent

### Build
```bash
docker build -t windows-jenkins-agent .
```

### Use
```bash
docker run --isolation=hyperv -p 2222:22 -v "//./pipe/docker_engine://./pipe/docker_engine" --name jenkins-agent jenkins/ssh-agent:windowsservercore-ltsc2019-jdk11
   -Url http://jenkins-server:port 
   -WorkDir=C:/Users/jenkins/Agent
   -Secret <SECRET> 
   -Name <AGENTNAME>
```