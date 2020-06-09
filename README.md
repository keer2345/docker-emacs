# Dockerk Emacs

参考：
- https://zhuanlan.zhihu.com/p/61657169

```
docker build -t docker-emacs .

docker run -it --rm  -v <path>/docker-emacs/.emacs.d:/root/.emacs.d -v ~/workspace:/var/opt docker-emacs
```

或者添加下行到 `~/.zshrc` :

```
alias demacs="docker run -it --rm  -v <path>/docker-emacs/.emacs.d:/root/.emacs.d -v ~/workspace:/var/opt docker-emacs"
```
然后
```
source ~/.zshrc
```

就可以通过运行 `demacs` 来调出 Emacs 了。
