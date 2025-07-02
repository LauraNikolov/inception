# Inception
Inception is a system administration project from 42 school.  
The goal is to deepen my Docker skills by creating a mini infrastructure with multiple Docker containers on a personal virtual machine.

## What I did  
- Set up several Docker containers: Nginx (with TLS 1.2 or 1.3), WordPress with PHP-FPM, and MariaDB.  
- Each service runs in its own container, built from custom Dockerfiles using Alpine or Debian (stable, not latest).  
- Created persistent volumes for WordPress files and its database.  
- Configured a Docker network to allow communication between containers.  
- Ensured containers restart automatically on failure.  
- Used environment variables and Docker secrets to manage sensitive data securely.  
- Nginx acts as the single entry point on port 443, enforcing TLS only.  
- Configured WordPress with two users, including a secure admin username (not containing "admin").  
- Mapped the domain `login.42.fr` (with my login) to the local IP for easy access.  
- Automated build and deployment using a Makefile and docker-compose.yml.  

## Project structure  
- `srcs/` contains all source files including Dockerfiles and configs.  
- `.env` stores environment variables.  
- Makefile automates image build and container management.  

## Important rules  
- No usage of pre-built images except Alpine/Debian base images.  
- No use of deprecated Docker networking options like `--link` or `host` mode.  
- No infinite loops or hacks to keep containers running (like `tail -f` or `sleep infinity`).  
- Latest tags are forbidden.  
- Passwords never hardcoded in Dockerfiles.  


---
