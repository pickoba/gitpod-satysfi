FROM ocaml/opam:ubuntu-22.04-ocaml-4.14 AS build

RUN sudo apt-get update && sudo apt-get install -y \
    autoconf \
 && sudo rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/gfngfn/SATySFi

WORKDIR /home/opam/SATySFi

RUN git switch dev-0-1-0-separate-saphe-from-satysfi
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam update && opam install -y . --deps-only
RUN opam exec -- make all
RUN opam install -y .

FROM gitpod/workspace-base

COPY --from=build /home/opam/SATySFi/satysfi /usr/local/bin/satysfi
COPY --from=build /home/opam/SATySFi/saphe /usr/local/bin/saphe

USER gitpod
