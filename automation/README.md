# Automating Infrastructure on Google Cloud with Terraform

- Terraform is a tool that allows you to build, change, and version infrastructure safely and efficiently. It supports popular service providers and custom in-house solutions.
- Configuration files provide Terraform with the necessary information to run a single application or an entire data center. Terraform generates an execution plan to describe the steps it will take to reach the desired state, and then executes that plan to build the infrastructure. As the configuration changes, Terraform can determine what has changed and generate incremental execution plans that can be applied.
- Terraform can manage both low-level components such as compute instances, storage, and networking, as well as high-level components like DNS entries and SaaS features.
- Key features:
  - Infrastructure as code
  - Execution plans
  - Resource graph
  - Change automation
- Terraform is pre-installed in Cloud Shell.
- Configuration files with the extensions `.tf` or `.tf.json` are recognized by Terraform and loaded when it runs.
- A destructive change refers to a change that requires replacing an existing resource instead of updating it. This typically happens when the cloud provider does not support updating the resource as described in the configuration.
- Terraform uses implicit dependency information to determine the correct order for creating and updating resources.
- In some cases, there may be dependencies between resources that are not apparent to Terraform. To explicitly define dependencies, you can use the `depends_on` argument, which accepts a list of resources.
- Similar to `terraform apply`, Terraform determines the order in which resources should be destroyed.

# Initialize, Apply, Verify & Destroy

- `terraform init`
- `terraform apply`
- `terraform show`
- `terraform destroy`
