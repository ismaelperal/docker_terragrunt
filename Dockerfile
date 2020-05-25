FROM alpine

ARG TERRAFORM_VERSION
ARG TERRAGRUNT_VERSION

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

WORKDIR /live
ENTRYPOINT [ "/bin/zsh" ]
