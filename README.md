# porter-preview-action

This Github action creates a new preview environment in Porter.

## Usage

```yaml
steps:
  - name: Checkout code
    uses: actions/checkout@v2.3.4
  - name: Get PR ID
    id: pr_id
    run: |
      pr_id=${echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }'}
      echo ::set-output name=pr_id::$pr_id
    env:
      GITHUB_REF: ${{ github.ref }}
  - name: Create Porter preview environment
    uses: porter-dev/porter-preview-action@v0.1.0
    with:
      cluster: 1234
      project: 4321
      token: ${{ secrets.PORTER_TOKEN }}
      namespace: pr-${{ steps.pr_id.outputs.pr_id }}
      pr_id: 100
      installation_id: 12344321
```

## Configuration Options

The possible inputs are:

- `token`: (string, required): Token for Porter authentication.
- `project`: (number, required): Project ID of Porter project.
- `cluster`: (number, required): Cluster ID of Porter cluster.
- `namespace`: (string, required): Namespace of the application (default "default")
- `pr_id`: (number, required): The ID of the pull request
- `installation_id`: (number, required): The installation ID for the Github app which manages preview envs
- `host`: (string, optional): Host URL of Porter instance. Set this if you use a self-hosted Porter instance.
- `file`: (string, optional): The path to the `porter.yaml` file (default "./porter.yaml").
