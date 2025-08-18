# Get all available AWS availability zones in the current region
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the main VPC with DNS support enabled
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, { Name = "${var.project_name}-vpc" })
}

# Create internet gateway for public subnet internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project_name}-igw" })
}

# Create public subnets across multiple availability zones
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[tonumber(each.key)]
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "${var.project_name}-public-${each.key}", Tier = "public" })
}

# Create private subnets across multiple availability zones
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[tonumber(each.key)]
  tags = merge(var.tags, { Name = "${var.project_name}-private-${each.key}", Tier = "private" })
}

# Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project_name}-public-rt" })
}

# Add default route to internet gateway for public subnets
resource "aws_route" "public_default" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

# Create route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project_name}-private-rt" })
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
}