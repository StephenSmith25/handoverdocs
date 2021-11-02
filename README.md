# handoverdocs


To build pdfs of the docs you can use pandoc. On osx install:

```
brew install pandoc```
```
Now install tex
```
brew install basictex
```
Install the mermaid folter
```
npm i -g mermaid-filter
```
As an example, run:
```
pandoc  -F mermaid-filter conda_build.md -o conda_build.pdf -V papersize:a4 --highlight-style pygments
```

Once the dependencies are install you can run the build script build.sh

Else you can view the docs in vscode.
