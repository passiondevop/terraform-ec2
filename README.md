# EC2 Module Setup (Terraform + GitHub Actions)

## Folder layout
```
.github/workflows/
  ec2.yml            # auto-runs plan+apply on push to ec2/**, or manual trigger
  ec2-destroy.yml     # manual-only destroy
ec2/
  main.tf             # calls the module
  variables.tf
  outputs.tf
  backend.tf           # S3 backend config (edit or remove)
  modules/
    ec2-instance/
      main.tf          # creates N EC2 instances, reuses existing SG
      variables.tf
      outputs.tf
```

## Before first run

1. **Edit `ec2/backend.tf`** — set `bucket` to an S3 bucket you already own,
   or delete the whole `backend "s3" {}` block to use local state instead.

2. **Repo secret** (Settings → Secrets and variables → Actions → Secrets):
   - `AWS_ROLE_ARN` = your IAM role ARN (the one already trusted for GitHub OIDC)

3. **Repo variable** (Settings → Secrets and variables → Actions → Variables):
   - `EC2_AMI_ID` = the AMI ID to launch (e.g. current Amazon Linux 2023 in us-west-2)

4. **IAM role permissions** — make sure the role in `AWS_ROLE_ARN` has EC2
   permissions attached (RunInstances, TerminateInstances, DescribeInstances,
   DescribeSubnets, DescribeVpcs, DescribeSecurityGroups, CreateTags, etc.)
   in addition to whatever it already has for EKS.

5. **Security group** — the module looks up an *existing* SG named
   `github-runner` in the default VPC (see `security_group_name` in
   `ec2/main.tf`). Change that value if you want a different SG name.

## Running it

- **Apply**: push a change under `ec2/**` to `main`, or go to
  Actions → "EC2 Provision" → Run workflow.
- **Destroy**: Actions → "EC2 Destroy" → Run workflow (manual only, never
  runs automatically).

## Notes
- `instance_count` defaults to 2 in `ec2/main.tf` (`instance_count = 2`).
  Change that number to scale up/down.
- Every variable has a default except `ami_id`, so `terraform plan` will
  never hang waiting for interactive input in CI (this was a problem in
  an earlier setup — keep it this way).
