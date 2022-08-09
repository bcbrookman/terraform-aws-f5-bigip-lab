
resource "aws_network_interface" "f5lab_bigip_external_if" {
  subnet_id   = aws_subnet.f5lab_external_net.id
  tags = { Name = "f5lab_bigip_external_if" }
}

resource "aws_network_interface" "f5lab_bigip_internal_if" {
  subnet_id   = aws_subnet.f5lab_internal_net.id
  tags = { Name = "f5lab_bigip_internal_if" }
}

resource "aws_instance" "f5lab_bigip" {
  ami = "ami-0daffdedb72c05d5f"
  instance_type = "m4.large"
  network_interface {
      network_interface_id = aws_network_interface.f5lab_bigip_external_if.id
      device_index         = 0
  }
  network_interface {
      network_interface_id = aws_network_interface.f5lab_bigip_internal_if.id
      device_index         = 1
  }
  tags = { Name = "f5lab_bigip" }
  depends_on = [ aws_subnet.f5lab_external_net ]
}