# **Building Environment for automatic testing by robot framework and python on Docker**
To run the automatic test, we use the sutomatic testing tool RobotFramework, the library **Browser** allow us create any web browser, such as Chrome, Firefox, and Edge. Pull the following docker image to build the environment for your docker.

### **Build the Docker image**
**Docker image :** 
```
docker pull ghcr.io/marketsquare/robotframework-browser/rfbrowser-stable:17.5.2
```
([reference](https://hub.docker.com/r/marketsquare/robotframework-browser))

### **Run a container under the image**
**Docker run:**
```
docker run -u ${username} --net=${network type} -v ${file path on local}:{path on virtual} -it ghcr.io/marketsquare/robotframework-browser/rfbrowser-stable:17.5.2 bash
```

`-u ${username}` : for role control. 
 `--net=${network type}` is for LAN control, host is connect to local host. ([reference](https://azole.medium.com/docker-container-%E5%9F%BA%E7%A4%8E%E5%85%A5%E9%96%80%E7%AF%87-2-c14d8f852ae4/))
 `-v ${file path on local}:{path on virtual}`: mount the file from local(pc) to virtual(docker container).
 
**Example**
```
docker run -u root --net=host -v C:\Users\charlottechen\personal\RF\robot:/RF_data -v C:\Users\charlottechen\personal\RF\report:/report -v C:\Users\charlottechen\personal\RF\script:/script -it ghcr.io/marketsquare/robotframework-browser/rfbrowser-stable:17.5.2 bash
```

### **Run testing file in the container**
`robot -d ${report path} ${robot file path}`

> Refer to the report of the test robot file:
<img width="920" alt="螢幕擷取畫面 2023-11-01 115413" src="https://github.com/heehee812/Automatic-testing/assets/57358478/89299a26-af2a-408a-9369-2dd25208e570">

>>>>>>> 5630ba1a67957d5e75afec80afce96cb4978a319

### **Update Instruction**
**Update from commandline:** 
`pip install -U robotframework-browser`
**Clean old node side dependencies and browser binaries:** 
`rfbrowser clean-node?`
**Install the node dependencies for the newly installed version:** 
`rfbrowser init>`

### **Keyword Library**
https://marketsquare.github.io/robotframework-browser/Browser.html



---

# **Reference**
## **Docker Installation**
https://docs.docker.com/get-docker/

## **Docker Instruction**
For building your own docker image and run it in the container, please refer to the following instruction. Note that the parameter contained can be important.

### **Build an image with the name ... by an dockerfile**
`docker build . -t charlottechen/robotframework-browser`

### **Add volume and create a container from an images**
```
docker run -v C:\Users\charlottechen\personal\RF\robot:/RF_data -v C:\Users\charlottechen\personal\RF\report:/report -it {image_name} bash
```

### **Execute and login to the existing container**
```
docker start {container_id}
docker exec -it {container_id} bash
```

### **Run robot file**
`robot {-d {report_path}} {-v {variable}} {file_name}`
`robot {-d {report_path}} ${path_of_the_folder}` 

## **Example**
**For building image charlottechen/robotframework-browser**
```
docker build . -t charlottechen/robotframework
docker run -u root --net=host -v C:\Users\charlottechen\personal\automatic_test\SE_MB_PG:/RF_data -it charlottechen/robotframework bash
docker run --net=host -v C:\Users\charlottechen\personal\automatic_test\SE_MB_PG:/RF_data -it charlottechen/robotframework bash
```
