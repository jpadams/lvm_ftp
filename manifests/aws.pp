class lvm_ftp::aws (
  $region = 'us-west-2',
  $ami    = 'ami-6989a659',
  $type   = 't1.micro',
  $key    = 'jeremy_pl_west2',
  $tags   = { 'created_by' => 'Jeremy Adams', 'department' => 'tse', 'project' => 'LVM FTP', },
  $ip     = '50.112.118.60',
  $handle = 'LVM FTP',
) {

  ec2_instance { $handle:
    ensure          => present,
    region          => $region,
    image_id        => $ami,
    instance_type   => $type,
    key_name        => $key,
    security_groups => [$handle],
    user_data       => file('lvm_ftp/setup.sh'), 
    tags            => $tags,
  }

  ec2_securitygroup { $handle:
    ensure      => present,
    region      => $region,
    description => 'LVM FTP security group',
    ingress     => [
      { protocol => 'tcp', port => '22', cidr => '0.0.0.0/0', },
      { protocol => 'tcp', from_port => 20, to_port => 21, cidr => '0.0.0.0/0', },
      { protocol => 'tcp', from_port => 13000, to_port => 13100, cidr => '0.0.0.0/0', },
    ],
  }

  ec2_elastic_ip { $ip:
    ensure   => attached,
    region   => $region,
    instance => $handle,
  }

}
