# CloudTopia
This project was inspired from me having a bad experience when getting my passport. I thought that it would be cool to build a serverless application using various aws services to create an online solution where people can submit their passport photos for evaluation.

# Video Demo
If you would like to see me use this project and learn more information about how I created it here is the video 
https://www.youtube.com/watch?v=cIUlKKvtYc4
# Installation Commands
You will need to have an aws account for the installation process, Here is a great tutorial for creating an account https://www.youtube.com/watch?v=KkWQuSwuGFc
1. You will also need to change the endpoint variable located in the sns.tf file to your email so you can receive the results.
2. Clone this repo on your local machine
```
$ git clone https://github.com/yourusername/yourproject.git
$ cd yourproject
```

3. Export aws account secrets 
```
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

4. Run Terraform to deploy project to aws
```
$ terraform init
$ terraform plan
$ terraform apply
```
5. You will then insert "yes" into the terminal when prompted

Usage

Once your project is deployed, navigate to aws and upload a photo to the "cloud-topia-images" s3 bucket and then you should recieve and email with your results
# Features
Feature 1: Can scale up and down depending on traffic

Feature 2: Infastructure is automated using terraform allowing for reusabilty

# Project Status
This project is still under development as I will continue working on it


# Thank you!
I hope you enjoyed learning about my project!
