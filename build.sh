#!/usr/bin/env bash
set -ex


pandoc  -F mermaid-filter conda_build.md -o conda_build.pdf -V papersize:a4 --highlight-style pygments

pandoc  -F mermaid-filter conda_envs.md -o conda_envs.pdf -V papersize:a4 --highlight-style pygments

pandoc  -F mermaid-filter windows_debug.md -o windows_debug.pdf -V papersize:a4 --highlight-style pygments

pandoc  -F mermaid-filter packaging.md -o packaging.pdf -V papersize:a4 --highlight-style pygments

pandoc  -F mermaid-filter general_docs.md -o general_docs.pdf -V papersize:a4 --highlight-style pygments
