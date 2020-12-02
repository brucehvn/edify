#### Passwords, etc.
The sensitive information about the AWS account, etc. is in a text file which is located in the encrypted zip called edify-info.zip.  The password for this zip will be sent to you via email.

#### Notes
I have the three peered VPCs working and have video to show pinging servers from all three AWS regions to the t2.micro servers in the other regions.  That entire part of the challenge was done via Terraform and the files are here in the terraform folder.

I deployed an nginx application to the EKS cluster. This installation is working as requested and is available publically.

The kubernetes dashboard is installed, and is working, though it's using a self-signed certificate and your browser might complain.

### Verifications
#### Nginx installation
To verify the nginx installation, using it's current amazon assigned dns name, you can access it at:
```
http://aa1bc83d03fbc42e5adc2439730617ff-1029812456.us-west-2.elb.amazonaws.com
```
The same URL can be used for the curl verification.
#### Kubernetes Dashboard Installation
First, you will need to obtain a token to use for signing into the dashboard. After configuring kubectl to point to this installation, then run the command:
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```
To obtain the token necessary for authentication. Copy the token from the terminal for use later.

You can then access the console by going to the following address:
```
https://a1ee188eb86d6493f9dc35cdee64167e-1758973131.us-west-2.elb.amazonaws.com
```
Since I used a self-signed certificate, the browser might complain. Hopefully, you can continue after being warned.

Use the token copied above to login.

### In closing
This was my first exposure to EKS.  I've used Kubernetes in the past, but not through EKS.

It was a fun and unique challenge overall and I thank you for the opportunity however things go.

Sincerely,
Bruce Hellstrom

