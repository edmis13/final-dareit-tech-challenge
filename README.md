# DareIT Tech Challenge (Task #8)

## Table of contents:

1. Goal of the challenge
2. Requirements & Bonus Requirements
3. Solution
    1. Tools
    1. Setup
4. Further improvements

## 1. Goal of the challenge.

The goal of the final task was to apply the knowledge I gained during the Cloud Challenge to deploy a simple website.

As a part of the final tech challenge I have been asked to create and deploy a website. I was expected to meet the following requirements:

## 2. Requirements.

- Deliver the tooling to set up an application that displays a web page with Lorem Ipsum text and an image
- Provide source code for creating the stack in a publicly available repository e.g. Github (https://github.com)
- Provide basic setup documentation to run the application
- All resources should be deployed using Terraform
- Automate the deployment of your application using CI/CD

**Bonus requirements:**

- Provide and document a mechanism for scaling the service and delivering the content to a larger audience
- Demonstrate that you have considered how a real-world solution will be hosted and scaled.
- Explain your choices.

I decided to create a static website hosted in a Google Cloud Storage bucket. 

## 3. Solution.
    
1. **Tooling.**

To setup an application that displays a static website with text and image the following tools are needed:

- Google Cloud Platform account
- Github Desktop - the tool to facilitate the use of Git
- VS Code - our code editor of choice

2. **Setup.**

*Please note that the source code contains resource names from my own project. To make it work correctly, please make sure that you update them to match your own resources*

**Step 1.** Clone this repository to be able to make changes to the source code on your local machine 

The application contains Terraform configuration files so that we can deploy all resources using Terraform as well as automate the deployment of the application using CI/CD; 

To ensure that Terraform is authorized to make changes to your GCP project, complete the following steps:

**Step 2.** Create a service account for Terraform

Google Cloud Console > IAM & Admin > IAM > Create Service Account

- Provide a name e.g. `terraform` > click Create
- Select a role: Project > Editor > click Continue
- Skip the rest, click Done

**Step 3.** Generate Key for a newly created Service Account

Click on the name of a new service account > KEYS > ADD KEY > Create new key > select JSON; a JSON key will be automatically downloaded to your device, you will need it later

**Step 4.** In your Github repository, go to Settings. 

Settings > Security > Actions > click `New repository secret`

Paste content of your .json file and name the secret TF_GOOGLE_CREDENTIALS. Save.

**Step 5.** Modify files to match names from your GCP project; e.g. in backend.tf:

```
terraform {
  required_version = ">= 1.0.11"
  backend "gcs" {
    bucket = "YOUR_BUCKET_NAME_FOR_STATE_FILE"
    prefix = "terraform/state"
  }
}
```
**Step 7.** Commit and push changes to remote repository.

*Terraform CI/CD workflow is set up to be triggered only when a new pull request is created. Edit the original .yml file if needed.*

**Step 8.** Go back to Google Console > Buckets > go to the newly created bucket > Click Copy URL and paste it to your browser.

*Note: Terraform configuration includes granting access to allUsers to make files in this bucket publically available.*

**Step 9.** Enjoy 🎉