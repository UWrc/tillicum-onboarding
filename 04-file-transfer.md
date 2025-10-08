# Data Transfer: Moving Files To and From Tillicum

Efficient and reliable data transfer is a key part of working on Tillicum. There are two main ways to move files between your local computer and the cluster:

| Method                           | Best For                               | Notes                                                                            |
| -------------------------------- | -------------------------------------- | -------------------------------------------------------------------------------- |
| **`scp` (Secure Copy Protocol)** | Small to medium file transfers         | Simple and available by default on all systems                                   |
| **Globus**                       | Large datasets, unsupervised transfers | Automatically handles restarts and failures, ideal for long or complex transfers |

## Transfer Data with `scp`

`scp` (secure copy) works similarly to `ssh`—you’ll use your UW NetID credentials to securely copy data between your local machine and Tillicum.

**Pro Tip:** These commands must be run from your local terminal, not from inside Tillicum.

### Upload files from your local computer to Tillicum

```bash 
scp data_to_transfer UWNetID@tillicum.hyak.uw.edu:/gpfs/scrubbed/UWNetID
```
Above replace the word UWNetID with your UWNetID in the login and the path section of the command. 

### Download files from Tillicum to your local computer

```bash
scp UWNetID@tillicum.hyak.uw.edu:/gpfs/scrubbed/UWNetID/tillicum-onboarding/loop_script.sh .
```
The `.` at the end of the command tells `scp` to place the files in your current working directory or "here."

## Transfer Data with Globus

While `scp` is great for quick transfers, **Globus** is the best way to move large datasets reliably and automatically.

Globus provides:
* **Automatic checkpointing** – if your connection drops, transfers resume from where they left off
* **Integrity checks** – ensures every file arrives intact
* **Unsupervised transfers** – no need to stay connected while data moves

As of Fall 2025, Tillicum is available as a Globus collection for data transfer. Globus is available on Hyak Klone, Kopah, and UW OneDrive, allowing for seamless and high-speed data transfers to and from Tillicum.

### Getting Started

1. Go to **<ins>https://www.globus.org</ins>** and Log In using University of Washington as your organization.

![Screenshot of globus.org showing the login button in the upper right corner.](/img/globus_login.png 'globus')

2. Sign in with your UW NetID and complete Duo 2FA.
3. Open the File Manager and search for the collection: **UW Hyak Tillicum**

![Screenshot showing how to search for the Tillicum endpoint.](/img/find_collection.png 'tillicum endpoint')

Bookmark this collection so you can easily access it later.

The root directory `/` will be the default path when you connect.

Navigate to your working directory by selecting `/gpfs/` by double clicking it, then selecting `scubbed/`, then your working directory, which should be you UWNetID, and then the git hub repository directory `tillicum-onboarding/`. 

This navigation can also be done by typing the path into the Path field, `/gpfs/scrubbed/UWNetID/tillicum-onboarding` after replacing the word UWNetID with your UW NetID. 

### Set Up Your Local Endpoint

To transfer data between your computer and Tillicum, you’ll need to install Globus Connect Personal:

1. [**<ins>Download Globus Connect Personal</ins>**](https://www.globus.org/globus-connect-personal) for your operating system.
2. Follow the on-screen setup to name your computer (e.g., User-MacBook-Pro or Lab-Desktop).
3. Once configured, your computer becomes a personal endpoint in Globus. You can find it by searching your chosen name under Collections.

![Screenshot showing the result of setting up Globus Connect Personal Properly.](/img/gcp_endpoint.png 'personal endpoint')

## Practice Transfers

Globus has a two-pane view option which can allow you to see two collections in the same window and perform transfers between them. We’ll use the files in this training repository to practice moving data both ways.

1. In one panel of the Globus File Manager, open UW Hyak Tillicum.
2. In the other panel, open your personal endpoint (your local computer).

#### Try:
1. Transferring a file from **Tillicum → Local**
2. Transferring a file from **Local → Tillicum**

Globus will display progress in real time, and you’ll receive an email once the transfer is complete.

## OneDrive Connector (coming soon)

We’re excited to announce a OneDrive connector for Globus, allowing you to move files directly between OneDrive and Tillicum.

Stay tuned for updates as this feature is finalized.

💡 Did you know? UW community members receive 5 TB of storage on OneDrive as part of Microsoft 365. [**<ins>Learn more here.</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0034422)

## Learn More

* Globus User Documentation [**<ins>Learn more here.</ins>**](https://docs.globus.org/?_gl=1*s0ry7u*_ga*MTE2MzI4NzMxNi4xNzQyMzQxMTg3*_ga_7ZB89HGG0P*MTc0NDA3MjY1Ny4xNy4xLjE3NDQwNzI2NTcuMC4wLjA.)
* [**<ins>Video Tutorial: Introduction to Globus for Researchers and New Users</ins>**](https://www.youtube.com/watch?v=-j7Mp3FN1zo&list=PLLCSx-IFoBeu2F-HF-DMoc5_AUsvYft8c&index=2)
* [**<ins>Video Tutorial: Globus Connect Personal Setup</ins>**](https://www.youtube.com/watch?v=bpnVcAN99WY). *Note: the Endpoints Menu Tool appears to be deprecated and now "Endpoint" and "Collection" are synonymous. Your personal endpoint can be found by searching Collections.*
