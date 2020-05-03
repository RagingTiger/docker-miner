## About
Collection of `crypto miners`

## Building
This `Docker` image build is meant to use
[BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/)
(found in `docker --version` >= 18.09). This can be seen in the way the
`Dockerfile` is laid out (i.e. it has multiple stages and possible targets).
Specific targets can be built as follows (assuming you have a
`docker --version` >= 18.09):
```
$ DOCKER_BUILDKIT=1 docker build --target production -t tigerj/mnr .
```

## TODO
+ Research [pycryptonight](https://pypi.org/project/py-cryptonight/)
+ Research [pip install --user](https://pip.pypa.io/en/stable/user_guide/)
+ Research [PYTHONPATH](https://realpython.com/lessons/module-search-path/)
+ Research [XMRIG Advanced Build](https://xmrig.com/docs/miner/ubuntu-build)
