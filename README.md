# OVERVIEW
## Usage
0. Run in dev container
1. Paste your AWS Credentials
```
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_SESSION_TOKEN="..."
```
2. Run terragrunt plan/apply in
  - main/state-backend (only on first run to setup s3 backend)
  - main/self-host to generate self-host infrastructure

## Other
Pre-requisites:
- Follow Part 1 of setup here - https://github-aws-runners.github.io/terraform-aws-github-runner/getting-started/

Final setup:
- Apply this infrastructure via usage

Github self-hosted runners
- Follow Part 3 of setup here - https://github-aws-runners.github.io/terraform-aws-github-runner/getting-started/
