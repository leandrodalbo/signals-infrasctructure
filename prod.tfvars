env     = "prod"
appname = "trading-signals"

ssl_cert = "ssl/cert.json"

dbid            = "tradingsignalsdb"
dbclass         = "db.t3.micro"
dbengine        = "postgres"
dbengineversion = "16.4"

vpc_cidr = "10.0.0.0/16"

zone_a = "eu-west-2a"
zone_b = "eu-west-2b"
zone_c = "eu-west-2c"

public_cidr_a = "10.0.1.0/24"
public_cidr_b = "10.0.2.0/24"
public_cidr_c = "10.0.3.0/24"

private_cidr_a = "10.0.4.0/24"
private_cidr_b = "10.0.5.0/24"
private_cidr_c = "10.0.6.0/24"

nateip = "10.0.0.5"
