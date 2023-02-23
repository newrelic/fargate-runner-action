[![Community Project header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Community_Project.png)](https://opensource.newrelic.com/oss-category/#community-project)

# Fargate Runner Action

GitHub Action that allows to execute given Fargate task and stream logs back.

## Usage

In order to use this Github Action you will need to add the following code snippet to your GitHub workflow file.

```yaml
env:
  AWS_ASSUME_ROLE: 'arn:aws:iam::018789649883:role/caos-pipeline-oidc'
  ANSIBLE_FORKS: 20

permissions:
  id-token: write

jobs:
  test-with-fatgate:
    name: Testing something with fargate task
    runs-on: ubuntu-22.04

    steps:
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          role-to-assume: ${{ env.AWS_ASSUME_ROLE }}
          aws-region: us-east-2

      - name: Fargate task
        uses: newrelic/fargate-runner-action@v1
        with:
          aws_region: us-east-2
          container_make_target: "test"
          ecs_cluster_name: fargate_cluster_1
          task_definition_name: fargate_task_1
          cloud_watch_logs_group_name: /ecs/fargate-logs
          cloud_watch_logs_stream_name: ecs/fargate-logs
          aws_vpc_subnet: ${{ secrets.AWS_VPC_SUBNET }}
          repo_name: "newrelic/infrastructure-agent"
          ref: "main"


```

### Inputs

| Key                            | Description                                                               |
|--------------------------------|---------------------------------------------------------------------------|
| `aws_region`                   | AWS region where the fargate cluster is                                   |
| `aws_vpc_subnet`               | AWS vpc for the Fargate cluster                                           |
| `ecs_cluster_name`             | AWS fargate cluster name                                                  |
| `task_definition_name`         | AWS fargate task definition name                                          |
| `container_make_target`        | Command to run in the task container                                      |
| `cloud_watch_logs_group_name`  | AWS cloud watch logs group name. Needed to stream logs back               |
| `cloud_watch_logs_stream_name` | AWS cloud watch logs stream name. Needed to stream logs back              |
| `log_filters`                  | List of regex filters to filter out unwanted logs                         |
| `repo_name`                    | Repo name to clone by the docker. Example: newrelic/infrastructure-agent. |
| `ref`                          | Branch or TAG to be checked out in the docker container.                  |

## Support

New Relic hosts and moderates an online forum where customers can interact with New Relic employees as well as other
customers to get help and share best practices. Like all official New Relic open source projects, there's a related
Community topic in the New Relic Explorers Hub. You can find this project's topic/threads here:

* [New Relic Documentation](https://docs.newrelic.com): Comprehensive guidance for using our platform
* [New Relic Community](https://discuss.newrelic.com/c/support-products-agents/new-relic-infrastructure): The best place
  to engage in troubleshooting questions
* [New Relic Developer](https://developer.newrelic.com/): Resources for building a custom observability applications
* [New Relic University](https://learn.newrelic.com/): A range of online training for New Relic users of every level
* [New Relic Technical Support](https://support.newrelic.com/) 24/7/365 ticketed support. Read more about
  our [Technical Support Offerings](https://docs.newrelic.com/docs/licenses/license-information/general-usage-licenses/support-plan)
  .

## Contribute

We encourage your contributions to improve Fargate Runner Action! Keep in mind that when you submit your pull request,
you'll need to sign the CLA via the click-through using CLA-Assistant. You only have to sign the CLA one time per
project.

If you have any questions, or to execute our corporate CLA (which is required if your contribution is on behalf of a
company), drop us an email at opensource@newrelic.com.

**A note about vulnerabilities**

As noted in our [security policy](../../security/policy), New Relic is committed to the privacy and security of our
customers and their data. We believe that providing coordinated disclosure by security researchers and engaging with the
security community are important means to achieve our security goals.

If you believe you have found a security vulnerability in this project or any of New Relic's products or websites, we
welcome and greatly appreciate you reporting it to New Relic through [HackerOne](https://hackerone.com/newrelic).

If you would like to contribute to this project, review [these guidelines](./CONTRIBUTING.md).

To all contributors, we thank you!  Without your contribution, this project would not be what it is today.

## License

Fargate Runner Action is licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.
