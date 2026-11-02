# TJLFEP (TimSlendebroek fork) changelog

This fork is part of the FUSE design stack (see github.com/TimSlendebroek/FUSE_Design.jl). Versions are
`<upstream version at the split>+design.<n>`; they satisfy the same compat bounds as the upstream version and never
clash with upstream release numbers. Releases are git tags `v<version>`.

## 2.0.14+design.1 (2026-11-02, branch `lean-deps`)

Upstream v2.0.14 plus:

- `make_crit_grad_plots` moved into a Plots extension (`ext/TJLFEPPlotsExt.jl`): TJLFEP loads without Plots.
- `make_crit_grad_plots` reads the output of `write_crit_grad` by default (`code="auto"`).
- Tests for the Plots extension.
