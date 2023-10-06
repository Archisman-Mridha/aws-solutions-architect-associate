// Parameters are grouped together into named parameter groups for easier parameter management. A
// parameter group represents a combination of specific values for the parameters that are passed to
// the engine software during startup. These values determine how the engine processes on each node
// behave at runtime. The parameter values on a specific parameter group apply to all nodes that are
// associated with the group, regardless of which cluster they belong to.
// You can read more here - https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/ParameterGroups.Management.html.
resource "aws_elasticache_parameter_group" "default" {
  name = "test"
  family = "redis3.2"

  parameter {
    name = "cluster-enabled"
    value = "no"
  }
}