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
        }
}
