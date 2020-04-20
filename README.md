
## Project Summary
using jenkins pipeline to deploy apache app with the help of blue and green deployment strategy.

## Installation

* Build the pipeline using jenkins build and the docker image will be built and push to the public registery on docker hub
and then the kurbernetes cluster will be used to deploy the docker image on kurbernetes pods using kubectl.

### Other Libraries

* Docker
* Hadolint 
* Kurbernetes (eks)
* linter
* aws cli

## Project Files
* cloudformation: folder include the automation scripts for creating the eks cluster
* Dockerfile: container code which include the base image and all the dependencies
* Jenkinsfile: the pipeline code which will be executed by the jenkins
* deploy-blue.yaml: kurberntes deployement description file for staging env.
* deploy-green.yaml: kurberntes deployement description file for prod env.
* service-blue.yaml: kurberntes service description file for staging env.
* service-green.yaml: kurberntes service description file for prod env.
* index.html: the html file used as sample for an app
