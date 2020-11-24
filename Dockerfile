# ------------------- builder stage
FROM ghcr.io/gentoo-docker-builds/gendev:latest as builder

# ------------------- emerge
RUN emerge -C sandbox
COPY portage/terraform.accept_keywords /etc/portage/package.accept_keywords/terraform
COPY portage/terraform.license /etc/portage/package.license/terraform
RUN ROOT=/terraform FEATURES='-usersandbox' emerge app-admin/terraform

# ------------------- empty image
FROM scratch
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY --from=builder /terraform /
