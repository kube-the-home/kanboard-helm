## [1.1.1](https://github.com/kube-the-home/kanboard-helm/compare/1.1.0...1.1.1) (2025-10-19)


### Bug Fixes

* **deps:** update docker.io/kanboard/kanboard docker tag to v1.2.48 ([434f411](https://github.com/kube-the-home/kanboard-helm/commit/434f411095bac0880c905d1b08a788290d687e90))

# [1.1.0](https://github.com/kube-the-home/kanboard-helm/compare/1.0.3...1.1.0) (2025-09-12)


### Features

* adding env vars to application ([ea92e43](https://github.com/kube-the-home/kanboard-helm/commit/ea92e433a5680bb8e838b60c942182ce44afd6db))

## [1.0.3](https://github.com/kube-the-home/kanboard-helm/compare/1.0.2...1.0.3) (2025-08-15)


### Bug Fixes

* **deps:** update docker.io/kanboard/kanboard docker tag to v1.2.47 ([c3dcb3c](https://github.com/kube-the-home/kanboard-helm/commit/c3dcb3cc9203608408d049bfd208ab6d77f25935))

## [1.0.2](https://github.com/kube-the-home/kanboard-helm/compare/1.0.1...1.0.2) (2025-07-22)


### Bug Fixes

* use the new deploy token ([3d29e09](https://github.com/kube-the-home/kanboard-helm/commit/3d29e0997b687ba77d023a885f03d9d07757df41))

## [1.0.1](https://github.com/kube-the-home/kanboard-helm/compare/1.0.0...1.0.1) (2025-06-24)


### Bug Fixes

* **deps:** update docker.io/kanboard/kanboard docker tag to v1.2.46 ([79eb1ac](https://github.com/kube-the-home/kanboard-helm/commit/79eb1acc03d03c0ffc98cec34b26d374317c15f0))

# 1.0.0 (2025-05-13)


### Bug Fixes

* **deps:** update docker.io/kanboard/kanboard docker tag to v1.2.44 ([4f78353](https://github.com/kube-the-home/kanboard-helm/commit/4f78353fbfb60379d49ce7e43daa297af8218667))
* **deps:** update docker.io/kanboard/kanboard docker tag to v1.2.45 ([317a0e4](https://github.com/kube-the-home/kanboard-helm/commit/317a0e4b1962159fc9ce651773c0e1bdec97e6ab))
* **pvc:** create pvc with the right name ([58cf2ec](https://github.com/kube-the-home/kanboard-helm/commit/58cf2ec61f63f564b003550475556f7f6f5a8bc3))
* **security:** remove readonlyroot filesystem for now ([adfad7a](https://github.com/kube-the-home/kanboard-helm/commit/adfad7ab7a98555c101d8ce3c34750b9aaf52d27))


### Features

* add additional pod labels ([ab0ea62](https://github.com/kube-the-home/kanboard-helm/commit/ab0ea62cc510604eab7a5ccf8dcb259e25096815))
* add artifacthub badge ([600f18b](https://github.com/kube-the-home/kanboard-helm/commit/600f18b28c0d039e7b814943591eb7591b491b28))
* add automatic release ([3cc200d](https://github.com/kube-the-home/kanboard-helm/commit/3cc200d935ad1226045962240345935419c97e4b))
* add dependabot for actions ([61dcf7d](https://github.com/kube-the-home/kanboard-helm/commit/61dcf7dedcc2f57a98d24fa411cdd80abe84fbc2))
* add dependabot for docker ([c7a838e](https://github.com/kube-the-home/kanboard-helm/commit/c7a838e4a1ee37a398325a935a442da786be06f7))
* add github action to test for conventional commits ([ef95e21](https://github.com/kube-the-home/kanboard-helm/commit/ef95e213b8d7584fd932303a552fa31b983ac1bc))
* add helm docs action ([47a320a](https://github.com/kube-the-home/kanboard-helm/commit/47a320a3694b160008d61716b61317c3353c8660))
* add links to currently pretty empty docs ([a2ebe81](https://github.com/kube-the-home/kanboard-helm/commit/a2ebe81524f383da511798102556a8284cd11bf4))
* change storageclass to be default by default ([d7fb179](https://github.com/kube-the-home/kanboard-helm/commit/d7fb179bb2cfc98996257e73b9307b0622b21960))
* enable renovate ([611ddc3](https://github.com/kube-the-home/kanboard-helm/commit/611ddc314b5ad283bd7aba89bca13488104ba841))
* implicitly enable clusterip if ingress is enabled ([8d0b78e](https://github.com/kube-the-home/kanboard-helm/commit/8d0b78e398061a013edbe26338d7e5da1217f087))
* **ingress:** add ingress annotations ([3a4f18c](https://github.com/kube-the-home/kanboard-helm/commit/3a4f18c56178c3af48e6d8a326c91196abca8fc6))
* Initial add for kanboard helm chart ([01bca50](https://github.com/kube-the-home/kanboard-helm/commit/01bca50602977202b6224a8774547ffb3b32f53c))
* **persistence:** add persistence to sqlite db ([ca7926f](https://github.com/kube-the-home/kanboard-helm/commit/ca7926f6eac56de700b73acdddc72b5b36e7b2cf))
* **pvc:** move access mode to values ([542f0db](https://github.com/kube-the-home/kanboard-helm/commit/542f0db9f7fbd889655b6a2190b56c88e77122d5))
