Return-Path: <linux-kselftest+bounces-8280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF98A8F2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448A0282971
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF286260;
	Wed, 17 Apr 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARkg/1Ga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563D8563E;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395518; cv=none; b=TsDtLEB+1GmfD8GoXm4gPjPj+ooc78v1yG4vj7mwCWrGVXPjP9mHeUmw4qk3WH+N9i4t9C1V7O2mREaDYADNfSEYGFoSOJDmSblbRrcS9LdBolG5CuZJ32K4d7t7MvjZK5N2+FWhxki1NJC6kTQudC9qTlueGpccG68J5iGh4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395518; c=relaxed/simple;
	bh=9r/q5QrmyrRF7E9pmJFiMwRvEVAo1tgFGtcXTzt4+to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgyU8hFliXpRZZxHUGqD1lZ42Qzcr94lBFung1Uwh60ORl8Z4e6s9pTX3q5N3Ju7pWl4uIgNtAltXA848gqkXhub8FzRgGyzQiUiGLO2tOoYH1e092W9oZD4w4+QhNsz6KW92PKxLy1/ftWzzDdMJ1boY91HN3yG2j5fqB4lpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARkg/1Ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F90C4AF11;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395517;
	bh=9r/q5QrmyrRF7E9pmJFiMwRvEVAo1tgFGtcXTzt4+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARkg/1Ga6+bnfZwkIKiNtNy9uxYInaE8kXB2+HUbrFXSJN0ZCl5CEHyCTPASbLLbj
	 m+WTkQJ7G4oelLT2HROAlq+TZdIwgO5CFoWboGDJIWhMCM8AbZQwMVVqR9/8ZOXsbF
	 lyoZklXhG0vI6GoUFPAqBSh0jgFgToaFb6z3NJOrw5llJjXOB9FO4F8kfEmvfRaAOl
	 MONuJCfwsO/DAgDNcVQ/z3udVwxFVaTppCktDgrGUWgd3J8Aj5JLBlswrVj7hUfMwr
	 SgkCC5wUdRSZMCYcwR9ks0OK0hLbjlJQUuZt4Y0UR9FmYbuDs8UYbAR51LVJAg84y4
	 O5Udl251iMj/A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/8] selftests: drv-net: define endpoint structures
Date: Wed, 17 Apr 2024 16:11:41 -0700
Message-ID: <20240417231146.2435572-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the remote endpoint "model". To execute most meaningful device
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

2) Some systems may need to communicate with the remote endpoint
via SSH.

3) Last but not least environment may have its own custom communication
method.

Fundamentally we only need two operations:
 - run a command remotely
 - deploy a binary (if some tool we need is built as part of kselftests)

Wrap these two in a class. Use dynamic loading to load the Remote
class. This will allow very easy definition of other communication
methods without bothering upstream code base.

Stick to the "simple" / "no unnecessary abstractions" model for
referring to the remote endpoints. The host / remote object are
passed as an argument to the usual cmd() or ip() invocation.
For example:

 ip("link show", json=True, host=remote)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - make Remote() return Popen() object
 - always operate on absolute paths
v2:
 - rename Endpoint -> Remote
---
 .../selftests/drivers/net/lib/py/__init__.py  |  1 +
 .../selftests/drivers/net/lib/py/remote.py    | 15 +++++++
 .../drivers/net/lib/py/remote_netns.py        | 21 ++++++++++
 .../drivers/net/lib/py/remote_ssh.py          | 39 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   | 17 ++++----
 5 files changed, 85 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 4653dffcd962..4789c1a4282d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,3 +15,4 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     sys.exit(4)
 
 from .env import *
+from .remote import Remote
diff --git a/tools/testing/selftests/drivers/net/lib/py/remote.py b/tools/testing/selftests/drivers/net/lib/py/remote.py
new file mode 100644
index 000000000000..b1780b987722
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/remote.py
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import importlib
+
+_modules = {}
+
+def Remote(kind, args, src_path):
+    global _modules
+
+    if kind not in _modules:
+        _modules[kind] = importlib.import_module("..remote_" + kind, __name__)
+
+    dir_path = os.path.abspath(src_path + "/../")
+    return getattr(_modules[kind], "Remote")(args, dir_path)
diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_netns.py b/tools/testing/selftests/drivers/net/lib/py/remote_netns.py
new file mode 100644
index 000000000000..7d5eeb0271bc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_netns.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import subprocess
+
+from lib.py import cmd
+
+
+class Remote:
+    def __init__(self, name, dir_path):
+        self.name = name
+        self.dir_path = dir_path
+
+    def cmd(self, comm):
+        return subprocess.Popen(["ip", "netns", "exec", self.name, "bash", "-c", comm],
+                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+
+    def deploy(self, what):
+        if os.path.isabs(what):
+            return what
+        return os.path.abspath(self.dir_path + "/" + what)
diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
new file mode 100644
index 000000000000..924addde19a3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import string
+import subprocess
+import random
+
+from lib.py import cmd
+
+
+class Remote:
+    def __init__(self, name, dir_path):
+        self.name = name
+        self.dir_path = dir_path
+        self._tmpdir = None
+
+    def __del__(self):
+        if self._tmpdir:
+            cmd("rm -rf " + self._tmpdir, host=self)
+            self._tmpdir = None
+
+    def cmd(self, comm):
+        return subprocess.Popen(["ssh", "-q", self.name, comm],
+                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+
+    def _mktmp(self):
+        return ''.join(random.choice(string.ascii_lowercase) for _ in range(8))
+
+    def deploy(self, what):
+        if not self._tmpdir:
+            self._tmpdir = "/tmp/" + self._mktmp()
+            cmd("mkdir " + self._tmpdir, host=self)
+        file_name = self._tmpdir + "/" + self._mktmp() + os.path.basename(what)
+
+        if not os.path.isabs(what):
+            what = os.path.abspath(self.dir_path + "/" + what)
+
+        cmd(f"scp {what} {self.name}:{file_name}")
+        return file_name
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 19612348c30d..e80fea9f6562 100644
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
@@ -15,15 +13,18 @@ import subprocess
         self.ret = None
 
         self.comm = comm
-        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
-                                     stderr=subprocess.PIPE)
+        if host:
+            self.proc = host.cmd(comm)
+        else:
+            self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
+                                         stderr=subprocess.PIPE)
         if not background:
             self.process(terminate=False, fail=fail)
 
     def process(self, terminate=True, fail=None):
         if terminate:
             self.proc.terminate()
-        stdout, stderr = self.proc.communicate()
+        stdout, stderr = self.proc.communicate(timeout=3)
         self.stdout = stdout.decode("utf-8")
         self.stderr = stderr.decode("utf-8")
         self.proc.stdout.close()
@@ -37,12 +38,12 @@ import subprocess
                             (self.proc.args, stdout, stderr))
 
 
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


