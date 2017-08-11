# provision-digiocean
auto provision digital ocean droplet
Create an API token on Digital Ocean, using below method.

Next, in the top menu, click on API.
In the Personal Access Tokens section, click the Generate new token button:
 
You will be taken to the New Personal Access Token screen:
 
Here, provide the following information:
Your desired token name (for your own reference)
Select the scope for this token (read or read/write)
Then click the Generate Token button.
Your token will be generated and presented to you on your Personal Access Tokens page. The actual token is the long string of numbers and letters, under the name:
 
Be sure to record your personal access token now. It will not be shown again, for security purposes.
Using the API:

export TOKEN=<Token_ID>

Example: List all Actions
To list all of the actions that have been executed on the current account, send a GET request to /v2/actions:

    curl -X GET "https://api.digitalocean.com/v2/actions" \
    -H "Authorization: Bearer $TOKEN" 

Example: List all Droplets
To list all Droplets in your account, send a GET request to /v2/droplets:

    curl -X GET "https://api.digitalocean.com/v2/droplets" \
    -H "Authorization: Bearer $TOKEN" 

Example: Create a New Droplet
To create a new Droplet, send a POST request to /v2/droplets. For a full list of attributes that must be set to successfully create a droplet, see the full documentation. The following example creates an Ubuntu 14.04 droplet called "My-Droplet" in the BLR 1 data center, with 512MB RAM:

    curl -X POST "https://api.digitalocean.com/v2/droplets" \
    -d'{"name":"My-Droplet","region":"blr1","size":"512mb","image":"ubuntu-14-04-x64"}' \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" 

Note: This request, like any other request that makes a change to your account, requires that your token has "write" scope assigned to it.


Example: Create Multiple Droplets
You can also create multiple Droplets with the same attributes using a single API request by sending a POST to /v2/droplets. Instead of providing a single name in the request, provide an array of names. The following example creates two Ubuntu 14.04 Droplets, one called "sub-01.example.com" and one called "sub-02.example.com" They both are in the BLR 1 data center, with 512MB RAM:

    curl -X POST "https://api.digitalocean.com/v2/droplets" \
    -d'{"names":["sub-01.example.com","sub-02.example.com"],"region":"blr1","size":"512mb","image":"ubuntu-14-04-x64"}' \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" 

Using ansible to provision Droplet:
Configure Ansible,
1.	sudo apt-get install python-pip
2.	sudo pip install 'dopy>=0.3.5,<=0.3.5'   …. Install ‘dopy’
3.	create a new directory and move the ‘ansible.cfg’ file.
4.	Update the .cfg file with below entry.,

     [defaults]
      hostfile = hosts

update the hosts file with below entries, here the group name is 

     [digitalocean]
     localhost ansible_connection=local

There are three ways we can tell Ansible about the API token:
1.	Provide it directly on each DigitalOcean task, using the api_token parameter.
2.	Define it as a variable in the playbook or hosts file, and use that variable for the api_token parameter.
3.	Export it as an environment variable, as either DO_API_TOKEN or DO_API_KEY.


