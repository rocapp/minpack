from typing import Sequence
from quart import Quart, request, jsonify
import numpy as np
from minpack import lmdif

app = Quart(__name__)


@app.route('/lmdif', methods=['POST'])
async def lmdif_endpoint():
    try:
        data = await request.json
        # Replace with your actual function
        func = data.get('func') or data.get('fun')
        xdata: Sequence[float] = data.get('xdata') or data.get('x', [])
        ydata: Sequence[float] = data.get('ydata') or data.get('y', [])
        p0 = data.get('x0') or data.get('p0')
        p0 = np.array(p0).flatten()
        pcov = np.eye(len(p0), dtype=np.float64)
        pmu = np.eye(len(p0), dtype=np.float64)
        Niters = np.zeros(1, dtype=np.int64)
        args = data.get('args', (ydata, pcov, pmu, Niters))
        xtol = data.get('xtol', 1.49012e-8)
        gtol = data.get('gtol', 0.0)
        maxfev = data.get('maxfev') or data.get('max_nfev')
        if maxfev is None:
            maxfev = 150000
        fvec = np.zeros(len(xdata), dtype=np.float64)
        diag = np.ones(len(p0), dtype=np.dtype("f8"))
        # Call lmdif function
        ier = lmdif(func, p0, fvec, args=args, xtol=xtol, gtol=gtol,
                    maxfev=maxfev, diag=diag)
        return jsonify({'ier': ier, 'popt': p0.copy().tolist(),
                        'pcov': pcov.tolist(), 'fvec': fvec.tolist(),
                        'Niters': Niters.tolist}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400


if __name__ == '__main__':
    # trunk-ignore(bandit/B104)
    app.run(host='0.0.0.0', port=5000)
