#General scope

variable "machineType" {
  default = "e2-small"
}

#Network
variable "network"{
  default = "main"
}

variable "subnetwork"{
  default = "private-subnet"
}

variable "subnetworkRange"{
  default = "192.168.0.0/20"
}


#Cluster
variable "clusterName" {
  default = "cluster"
}

variable "clusterZone" {
  default = "us-west2-a"
}

variable "initialNodeCount" {
  default = 3
}

variable "clusterSecondaryName"{
  default = "gke-pods"
}

variable "clusterServiceName"{
  default = "gke-services"
}

variable "clusterSecondaryRange"{
  default = "10.4.0.0/14"
}

variable "clusterServiceRange"{
  default = "10.0.32.0/20"
}

variable "masterCidr"{
  default = "172.16.32.0/28"
}

variable "nodeCount" {
  default = 3
}

variable "autoscaling_min_node_count" {
  default = 3
}

variable "autoscaling_max_node_count" {
  default = 3
}

variable "diskSize" {
  default = 50
}

variable "diskType" {
  default = "pd-standard"
}

#Compute
variable "jumpName" {
  default = "jump-host"
}

#Other
variable "sshUser" {
  default = "user"
}

#ssh
#I'm using WSL, but the project is on my host system.
#This is why some paths may point to linux environmetns and others to windows
#Either way, change these to your needs
variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

#Outputs
output "clusterEndpoint" {
  value = google_container_cluster.gke-cluster.endpoint
}

output "instanceIp" {
  value = google_compute_instance.jump-host.network_interface.0.access_config.0.nat_ip
}