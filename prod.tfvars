postgres_db_id="tradingsignalsdb"
db_instance_class="db.t3.micro"
db_engine="postgres"
db_engine_version="16.4"

env="prod"
app_name="trading-signals"

vpc_cidr_block="10.10.0.0/16"

subnet_zone_a="eu-west-2a"
subnet_zone_b="eu-west-2b"

public_subnet_cidr_a="10.10.100.0/24"
public_subnet_cidr_b="10.10.101.0/24"

private_subnet_cidr_a="10.10.0.0/24"
private_subnet_cidr_b="10.10.1.0/24"
