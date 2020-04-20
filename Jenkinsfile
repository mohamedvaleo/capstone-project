pipeline 
{
    environment 
    {
        registry = "mohamdoo23/capstone-registry"
        dockerHubCredentials = 'dockerhublogin'
        dockerImage = ''
    }
    agent any
        stages 
        {
            stage('Lint HTML')
            {
                steps 
                {
                    script 
                    {
                        echo "Linting HTML File"
                        sh 'tidy -q -e index.html'
                    }
                }
            }
            stage('Lint Dockerfile')
            {
                steps
                 {
                    script 
                    {
                        echo "Linting Docker File"
                        sh 'wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 &&\
                        chmod +x hadolint'
                        sh './hadolint Dockerfile'
                    }
                }
            }
            stage('Build Dockerfile') 
            {
                steps 
                {
                    script 
                    {
                        echo "Build Docker File"
                        dockerImage = docker.build(registry + ":$BUILD_NUMBER")
                            
                    }
                }
            }
            
            stage('Image Security Scan') 
            {
              steps 
              { 
                 aquaMicroscanner imageName: (registry + ":$BUILD_NUMBER") , notCompliesCmd: '', onDisallowed: 'fail', outputFormat: 'html'
              }
            }         

            stage('Deploy Image') 
            {
                steps 
                {
                    script 
                    {
                        echo "Deploy Docker Image"
                        docker.withRegistry( '', dockerHubCredentials ) 
                        {
                            dockerImage.push()
                            
                        }
                    }
                }
            }

             stage('Create Blue Deployment') 
             {
                steps 
                {
                    withAWS(region:'us-east-1', credentials:'aws_key') 
                    {
                        sh 'aws eks --region us-east-1 update-kubeconfig --name capstone-project'
                        sh 'kubectl config use-context arn:aws:eks:us-east-1:610706151757:cluster/capstone-project'
                        sh 'kubectl delete deployment capstone-staging'
                        sh 'kubectl apply -f deploy-blue.yaml'
                        sleep(time:10,unit:"SECONDS")
                        sh 'kubectl apply -f service-blue.yaml'
                    }
                }
            }

            stage('Create Green Deployment') 
             {
                steps 
                {
                    withAWS(region:'us-east-1', credentials:'aws_key') 
                    {
                        sh 'aws eks --region us-east-1 update-kubeconfig --name capstone-project'
                        sh 'kubectl config use-context arn:aws:eks:us-east-1:610706151757:cluster/capstone-project'
                       // sh 'kubectl delete deployment capstone-staging'
                        sh 'kubectl apply -f deploy-green.yaml'
                        sleep(time:10,unit:"SECONDS")
                        sh 'kubectl apply -f service-green.yaml'
                    }
                }
            }
        }
}
