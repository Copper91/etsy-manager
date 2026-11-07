#!/bin/bash
# Patch jeffkimble/etsy-mcp-server for Etsy's Feb 2026 rule:
# x-api-key must be "keystring:shared_secret" on every request.
set -e
F=${1:-/opt/etsy-mcp-server/build/index.js}
grep -q "ETSY_XAPI_PATCH" "$F" && { echo "already patched"; exit 0; }
python3 - "$F" <<'PY'
import sys
p=sys.argv[1]; s=open(p).read()
s=s.replace("const { apiKey: API_KEY, refreshToken: REFRESH_TOKEN } = loadEtsyConfig();",
 "const { apiKey: API_KEY, sharedSecret: SHARED_SECRET, refreshToken: REFRESH_TOKEN } = loadEtsyConfig();\nconst X_API_KEY = `${API_KEY}:${SHARED_SECRET}`; // ETSY_XAPI_PATCH")
s=s.replace("""                refresh_token: REFRESH_TOKEN,
            });""","""                refresh_token: REFRESH_TOKEN,
            }, { headers: { "x-api-key": X_API_KEY } });""")
s=s.replace('headers.common["x-api-key"] = API_KEY;','headers.common["x-api-key"] = X_API_KEY;')
assert s.count("X_API_KEY")==3, "patch did not apply cleanly"
open(p,'w').write(s)
PY
echo patched
