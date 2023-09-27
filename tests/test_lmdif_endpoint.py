import requests
import pytest


def test_lmdif_endpoint():
    url = "http://localhost:5000/lmdif"
    
    # fun(p, fvec, args=(), **kwds)
    
    func_str = """
def func(p, fvec, args=(), **kwds):
    y, pcov, pmu, Niters = [np.array(a) for a in args]
    p = np.array(p, dtype=float)
    Niters[0] += 1 
    fvec[:] = (( y - (p[0] * y + p[1]) ) ** 2.0)[:]
"""
    # (ydata, pcov, pmu, Niters)
    payload = {
        "func": func_str,
        "xdata": [1.0, 2.0, 3.0],
        "ydata": [2.0, 4.0, 6.0],
        "x0": [1.0, 1.0, 1.0],
        "args": ([2.0, 4.0, 6.0], [[1.0]], [[1.0]], [0]),
        "xtol": 1.49012e-8,
        "gtol": 0.0,
        "maxfev": 150000
    }

    resp = requests.post(url, json=payload)

    print(resp)

    assert resp.status_code == 200


if __name__ == "__main__":
    test_lmdif_endpoint()
