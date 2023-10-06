resource "aws_elasticache_user" "default" {
  // Only the Redis engine supports user-password based authentication. If the underlying engine is
  // Memcached, then SAML authentication mechanism is used.
  engine = "REDIS"

  user_id = "archi"
  user_name = "archi"
  authentication_mode {
    type = "iam"
  }

  access_string = "on ~* +@all" // Access control list (ACL) rules for the user.
}