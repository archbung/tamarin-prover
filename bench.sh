for _ in 1 2 3 4 5; do
  env time --format=%M --output=bench.md --append \
    stack exec -- tamarin-prover --prove ~/projects/tls13-model/src/rev21/lemmas/uniqueness.spthy
done
