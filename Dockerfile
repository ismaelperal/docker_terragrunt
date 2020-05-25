FROM alpine:3

ENV TERRAFORM_VERSION="0.12.24"
ENV TERRAGRUNT_VERSION="0.23.12"

# Shell (zsh)
RUN echo "===> Installing zsh..."         && \
    apk --no-cache add zsh

# Dependencies
RUN echo "===> Installing git..."         && \
    apk --no-cache add git openssh-client && \
    echo "===> Adding Python runtime..."  && \
    apk --no-cache add openssl ca-certificates

# Terraform
RUN echo "===> Installing Terraform..."   && \
    wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip terraform.zip -d /bin && \
    rm -rf terraform.zip

# Terragrunt
RUN echo "===> Installing Terragrunt..."  && \
    wget -O /bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64"  && \
    chmod 0755 /bin/terragrunt

ENV PS1="%/ %# "

ENTRYPOINT [ "/bin/zsh" ]
