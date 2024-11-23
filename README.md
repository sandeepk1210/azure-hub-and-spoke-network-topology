# Deploy a Hub and Spoke Model Network Topology

In this lab, you are deploying application to separate networks, not just separate subnets on the same network. You decide to use network peering to allow communications between the components of the application, and you will use the hub & spoke network topology to minimize the number of connections required. Task will be to deploy a hub & spoke network topology and test it.

## Objectives

- Create Virtual Networks
- Create a Network Gateway
- Set up network peering
- Determine the effective routes of a network

### Create Three Virtual Networks

Create three virtual networks.

- Name them "**vnet-HUB**", "**vnet-spokeA**", and "**vnet-spokeB**"
- Ensure their IP address ranges are not overlapping
- Ensure they have /16 network spaces each
- Ensure the **default** subnet has /24 network spaces

### Create a Virtual Network Gateway on the Hub

The hub will require a virtual network gateway so that traffic can be routed between the spokes. Create one on a new subnet of the Hub.

### Create a Peering Relationship Between the Spokes and the Hub

Peer the network spokes to the hub.

- Peer vnet-spokeA with vnet-HUB
- Peer vnet-spokeB with vnet-HUB

### Add a Virtual Machine to the HUB

To test the peering relationship, we need to add a device to the network that can check the effective routes. Add a new Virtual Machine to the vnet-HUB default subnet, and check the effective routes of the attached virtual network interface card.

### Check the Effective Routing on the VM

Navigate to the VM you created, and look at the Effective Routing for it. Verify that the VM is able to navigate to the 10.1.0.0/16 network and the 10.2.0.0/16 network as well.
