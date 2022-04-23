FROM gitpod/workspace-base

RUN sudo install-packages opam

USER gitpod

# initialize opam
ARG OCAML_VERSION
RUN opam init --disable-sandboxing --compiler=$OCAML_VERSION
RUN echo '. /home/gitpod/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true' >> /home/gitpod/.bashrc

# add SATySFi repositories
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git \
    && opam repository add satyrographos https://github.com/na4zagin3/satyrographos-repo.git

# install SATySFi and Satyrographos
ARG SATYSFI_VERSION
ARG SATYROGRAPHOS_VERSION
RUN opam update && opam install --yes satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam exec -- satyrographos install

ENTRYPOINT ["opam", "exec", "--"]
