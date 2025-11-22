# NotesApp Project

This project automates the deployment of a full-stack application (Frontend, Backend, and Database) on a local Kubernetes cluster (Minikube).

The infrastructure is managed by **Terraform**, and the complete installation is orchestrated by a single **Ansible** playbook.

## 🚀 Quick Installation (One-Command)

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-user/mini-projet-ing5.git](https://github.com/your-user/mini-projet-ing5.git)
    cd mini-projet-ing5
    ```

2.  **Launch the full deployment:**
    This playbook installs Docker, Minikube, Terraform, Kubectl, configures the network, and deploys the application.
    ```bash
    cd ansible
    # The LC_ALL=C option prevents language-related errors with sudo prompts
    LC_ALL=C ansible-playbook -i inventory site.yml --ask-become-pass
    ```

3.  **Activate the network tunnel (Essential on Linux):**
    Open a **new terminal**, run this command, and keep it running:
    ```bash
    minikube tunnel
    ```
4. **Add the database Table**

The PostgreSQL database starts empty. Run this one-time command to create the necessary table:

```Bash

kubectl exec -it $(kubectl get pod -l app=notes-db -o jsonpath="{.items[0].metadata.name}") -- psql -U postgres -d notesdb -c "CREATE TABLE IF NOT EXISTS notes (id SERIAL PRIMARY KEY, content TEXT NOT NULL);" 
```
## ⚙️ Post-Deployment Configuration

If the URL does not work immediately, follow these steps:

**1. Verify the Ingress IP:**
Check the actual IP address assigned to the Ingress controller:
```bash
kubectl get ingress
```
**2.Update Terraform (Only if IPs mismatch):**
```cd ../terraform
# Replace 192.168.49.2 with your actual Ingress IP found above
terraform apply -var="vm_ip=192.168.49.2" -auto-approve
```

**3.Access the Application:**
 access http://notes.<ingress.ip>.nip.io
