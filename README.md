# CRYSTAL_KEMAL



## How to install
1. Install Crystal 
```
brew install crystal-lang
```
2. Create your application
```
crystal init app your_app_name
cd your_app
```
3. Add kemal to the shard.yml file as a dependency.
```
dependencies:
  kemal:
    github: kemalcr/kemal
    branch: master
```
4. Run shards to get dependencies:
```
shards install
```