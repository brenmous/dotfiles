from typing import List, Tuple
from collections import defaultdict
import os
import sys
import pprint

def compare_pip_installs(log_a: str, log_b: str) -> List[Tuple[str, str]]:
    def parse_log(log):
        deps = list()
        for l in log:
            if l.startswith('Successfully installed'):
                deprefixed = l[len('Successfully installed '): len(l)]
                dep_names = deprefixed.strip().split(' ')
                for dn in dep_names:
                    last_dash = dn.rfind('-')
                    name = dn[0: last_dash]
                    version = dn[last_dash + 1: len(dn)]
                    deps.append((name, version))
        return deps

    with open(log_a, 'r') as f:    
        a_deps = parse_log(f.readlines())
    with open(log_b, 'r') as f:
        b_deps = parse_log(f.readlines())

    comp = dict()
    for v in a_deps:
        comp[v[0]] = {'a': v[1]}
    for v in b_deps:
        if v[0] in comp.keys():
            comp[v[0]]['b'] = v[1]
        else:
            comp[v[0]] = {'b': v[1]}

    return comp
    
if __name__ == '__main__':
    pprint.pprint(compare_pip_installs(sys.argv[1], sys.argv[2]))
