Return-Path: <linux-kselftest+bounces-7888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDB8A38E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9B92834BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8BC152532;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3C4NqRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9D15252C;
	Fri, 12 Apr 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965037; cv=none; b=DN/Cq/WwbTaKojlwZriNKX4f2A3W/rLzIVLQ3F9OkCkATsb/mwuUqsJwhPFeuQDJSjqkXexGykCDm62lVU22d76wGFPkL4bEorccg/HdcxD+zgGkM/kc3f1sIJ1IW/u2aljnI1CuGrz3p97i3hvD0nVfeIn+i0GF4kQ9aHUX2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965037; c=relaxed/simple;
	bh=ZwZG8RwbY8C3v4KGuC84Ga0eey7PCYOdI1yJagyEpCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suGnAZib5wN06wxhlfxs09GiVIYdVHPcG+igg6tOTzcrlCYMrhsafGDND51yTNibwXQBFQWAhzFv8D8/ImNrxi9R8dDx9ThKQz714FVrLfPga2as0uAYwk0vXbWMuVDGxDocjsVPLn8Fj9VgQJcgddNmGj1CaMuqmowbsgxU2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3C4NqRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5D4C4AF07;
	Fri, 12 Apr 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965036;
	bh=ZwZG8RwbY8C3v4KGuC84Ga0eey7PCYOdI1yJagyEpCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3C4NqRjJo/d9vlFTnQNNB99bLej9/iLEOjx/3N/srum0Rxdpp/aXwtm4VAGasmHb
	 AsDQsOqteZcjBpKn0KWEop9N5ch1ALQYv6euJrY5IhPBHBMRAJ2+ByY/ifBWVCiTwX
	 iHdsLngQ7W6FZBTlYc8aIFV0dE8pMs8+euWJambA2xUWy677Rx685SyoN6B4LPCUJZ
	 CSuzpyQ3qFjK4gNoJSX+lAjjn8Ok0MWR7O+nMr7NQWFjNxhBb4R6EgZQqodK87ndu0
	 wWDnonTPvIzczdzOZNZ1EpUGVhefuQHg5jnOUVbL7FXLfsi0mqRYRs0oiewxGjrCa2
	 7dGkVJeGufPbA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] selftests: drv-net: define endpoint structures
Date: Fri, 12 Apr 2024 16:37:01 -0700
Message-ID: <20240412233705.1066444-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412233705.1066444-1-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the endpoint "model". To execute most meaningful device
driver tests we need to be able to communicate with a remote system,
and have it send traffic to the device under test.

Various test environments will have different requirements.

0) "Local" netdevsim-based testing can simply use net namespaces.
netdevsim supports connecting two devices now, to form a veth-like
construct.

1) Similarly on hosts with multiple NICs, the NICs may be connected
together with a loopback cable or internal device loopback.
One interface may be placed into separate netns, and tests
would proceed much like in the netdevsim case. Note that
the loopback config or the moving of one interface
into a netns is not expected to be part of selftest code.

2) Some systems may need to communicate with the endpoint via SSH.

3) Last but not least environment may have its own custom communication
method.

Fundamentally we only need two operations:
 - run a command remotely
 - deploy a binary (if some tool we need is built as part of kselftests)

Wrap these two in a class. Use dynamic loading to load the Endpoint
class. This will allow very easy definition of other communication
methods without bothering upstream code base.

Stick to the "simple" / "no unnecessary abstractions" model for
referring to the endpoints. The host / endpoint object are passed
as an argument to the usual cmd() or ip() invocation. For example:

 ip("link show", json=True, host=endpoint)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/__init__.py  |  1 +
 .../selftests/drivers/net/lib/py/endpoint.py  | 13 +++++++
 .../selftests/drivers/net/lib/py/ep_netns.py  | 15 ++++++++
 .../selftests/drivers/net/lib/py/ep_ssh.py    | 34 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   | 19 ++++++-----
 5 files changed, 73 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/endpoint.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_ssh.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 4653dffcd962..0d71ec83135b 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,3 +15,4 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     sys.exit(4)
 
 from .env import *
+from .endpoint import Endpoint
diff --git a/tools/testing/selftests/drivers/net/lib/py/endpoint.py b/tools/testing/selftests/drivers/net/lib/py/endpoint.py
new file mode 100644
index 000000000000..9272fdc47a06
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/endpoint.py
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import importlib
+
+_modules = {}
+
+def Endpoint(ep_type, ep_args):
+    global _modules
+
+    if ep_type not in _modules:
+        _modules[ep_type] = importlib.import_module("..ep_" + ep_type, __name__)
+
+    return getattr(_modules[ep_type], "Endpoint")(ep_args)
diff --git a/tools/testing/selftests/drivers/net/lib/py/ep_netns.py b/tools/testing/selftests/drivers/net/lib/py/ep_netns.py
new file mode 100644
index 000000000000..f5c588bb31f0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/ep_netns.py
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import cmd
+
+
+class Endpoint:
+    def __init__(self, name):
+        self.name = name
+
+    def cmd(self, *args):
+        c = cmd(*args, ns=self.name)
+        return c.stdout, c.stderr, c.ret
+
+    def deploy(self, what):
+        return what
diff --git a/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py b/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
new file mode 100644
index 000000000000..620df0dd8c07
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import shlex
+import string
+import random
+
+from lib.py import cmd
+
+
+class Endpoint:
+    def __init__(self, name):
+        self.name = name
+        self._tmpdir = None
+
+    def __del__(self):
+        if self._tmpdir:
+            self.cmd("rm -rf " + self._tmpdir)
+            self._tmpdir = None
+
+    def cmd(self, comm, *args):
+        c = cmd("ssh " + self.name + " " + shlex.quote(comm), *args)
+        return c.stdout, c.stderr, c.ret
+
+    def _mktmp(self):
+        return ''.join(random.choice(string.ascii_lowercase) for _ in range(8))
+
+    def deploy(self, what):
+        if not self._tmpdir:
+            self._tmpdir = "/tmp/" + self._mktmp()
+            self.cmd("mkdir " + self._tmpdir)
+        file_name = self._tmpdir + "/" + self._mktmp() + os.path.basename(what)
+        cmd(f"scp {what} {self.name}:{file_name}")
+        return file_name
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index f0d425731fd4..eff50ddd9a9d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -4,10 +4,8 @@ import json as _json
 import subprocess
 
 class cmd:
-    def __init__(self, comm, shell=True, fail=True, ns=None, background=False):
+    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
         if ns:
-            if isinstance(ns, NetNS):
-                ns = ns.name
             comm = f'ip netns exec {ns} ' + comm
 
         self.stdout = None
@@ -15,10 +13,13 @@ import subprocess
         self.ret = None
 
         self.comm = comm
-        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
-                                     stderr=subprocess.PIPE)
-        if not background:
-            self.process(terminate=False, fail=fail)
+        if host:
+            self.stdout, self.stderr, self.ret = host.cmd(comm)
+        else:
+            self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
+                                         stderr=subprocess.PIPE)
+            if not background:
+                self.process(terminate=False, fail=fail)
 
     def process(self, terminate=True, fail=None):
         if terminate:
@@ -36,12 +37,12 @@ import subprocess
             raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
 
 
-def ip(args, json=None, ns=None):
+def ip(args, json=None, ns=None, host=None):
     cmd_str = "ip "
     if json:
         cmd_str += '-j '
     cmd_str += args
-    cmd_obj = cmd(cmd_str, ns=ns)
+    cmd_obj = cmd(cmd_str, ns=ns, host=host)
     if json:
         return _json.loads(cmd_obj.stdout)
     return cmd_obj
-- 
2.44.0


