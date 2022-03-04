# percs

This Racket package provides a procedure that calculates a percentage of equality for the given two strings.

# Installing
```bash
raco pkg install -t git https://gitlab.com/crt0r/percs
```
or
```bash
raco pkg install percs
```

# Example
```scheme
(require percs)

(strings-equality-percentage "First string" "first string")
```

Running this code outputs `91.66666666666667`.

## NOTE
`strings-equality-percentage` always returns an inexact number.

# License
Licensed under the [MIT License](./LICENSE).

# Dependencies

- [levenshtein](https://pkgs.racket-lang.org/package/levenshtein)
