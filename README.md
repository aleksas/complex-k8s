[![Build Status](https://travis-ci.org/aleksas/nginx-redis-react-pg.svg?branch=master)](https://travis-ci.org/aleksas/nginx-redis-react-pg)

# nginx-redis-react-pg
## Shemas 
### Development 
![image](https://user-images.githubusercontent.com/594470/69322256-34702000-0c4d-11ea-9f71-d5db952ab0f6.png)
### Production 
![image](https://user-images.githubusercontent.com/594470/69324643-83b84f80-0c51-11ea-9501-a7da073d42f7.png)

## External preparations
### AWS

- Create an Elastic Beanstalk App
- Create AWS IAM (Identity and Access Management) User
- Set Travis project settings environment vars to have 
  - AWS_ACCESS_KEY
  - AWS_SECRET_KEY

### Docker Hub
- Set Travis project settings environment vars to have 
  - DOCKER_ID
  - DOCKER_PASSWORD
  
## References 
- [Udemi - Docker and Kubernetes: The Complete Guide](https://github.com/StephenGrider/DockerCasts)
