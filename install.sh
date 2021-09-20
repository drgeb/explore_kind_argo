#!/bin/sh

banner() {
cat <<"EOF"
KIND ARGO CI/CD
EOF
}

# Bootstrap script
PLAYBOOK="${1:-main}"

echo_exit() {
  echo "$1"
  exit "$2"
}

install_ansible() {
  if [ -e /etc/os-release ]; then
    . /etc/os-release
  fi

  if echo "$OSTYPE" | grep 'darwin' > /dev/null; then
    # we're MacOS
    command -v brew > /dev/null 2>&1 || echo_exit "Homebrew required" 1
    brew install ansible
  elif [ "$ID" = 'centos' ] && [ "$VERSION_ID" = "8" ]; then
    # we're CentOS 8
    sudo dnf install -y epel-release
    sudo dnf install -y ansible
  elif [ "$ID" = 'centos' ] && [ "$VERSION_ID" = "7" ]; then
    # we're CentOS 7
    sudo yum install -y epel-release
    sudo yum install -y ansible
  elif [ "$ID" = 'ubuntu' ] && [ "$VERSION_ID" = "20.04" ]; then
    # we're Ubuntu 20.04
    sudo apt install -y git ansible
  elif [ "$ID" = 'ubuntu' ] && [ "$VERSION_ID" = "18.04" ]; then
    # we're Ubuntu 18.04
    sudo apt install -y software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
  elif [ "$ID" = 'amzn' ] && [ "$VERSION_ID" = "2" ]; then
    # we're Amazon Linux 2
    sudo amazon-linux-extras install -y epel ansible2
  else
    # we're unsupported
    echo_exit "Unsupported OS" 1
  fi
}

# install ansible if not available
command -v ansible > /dev/null || install_ansible

# Run the playbook
echo "Enter sudo password for BECOME password."

ansible-playbook "playbooks/${PLAYBOOK}.yml" -i hosts -K && banner
