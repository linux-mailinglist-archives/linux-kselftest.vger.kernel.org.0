Return-Path: <linux-kselftest+bounces-6964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68065894893
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA671C221D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5965D528;
	Tue,  2 Apr 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUBTr+hw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD21D520;
	Tue,  2 Apr 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019941; cv=none; b=SFXJaYx1i5SVfLi/1GsoGf9JrKh6PIwvaO+VJFtalTtJ9sQkH4CYkL69f06CXUg3fpJBYt56AiRwfbRB28Kiiyj4yEz7zy5Ew2aTFauN3meyCmn/psuzZmzV6+ZapUs5AR+EHv9DSU6Jy0VX8b0NHwLN/FcucIcQrCFMWJl04/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019941; c=relaxed/simple;
	bh=6PXClB3QUgVAViliO7MIV0iqQSkf9RfbD9PiDXdhfuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du/5PVqhJxdhK60FRVUkDtlBy9wFgGK6zVTDqXXh4vjSKDs3Qrc9YicUPdc6bEYcQGKhgoHJ/+1MHkAqipMd0lBOAywmVuh0Maqj3LEsA8Mx4lRsPyrxY53Zq9V060E1AkgHgn9FD59gtY2ObwII4d57LHS9NrpgQ7YTjxihjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUBTr+hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E7C4166C;
	Tue,  2 Apr 2024 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019941;
	bh=6PXClB3QUgVAViliO7MIV0iqQSkf9RfbD9PiDXdhfuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUBTr+hw4X2Wm3mEc8wJHh2UUi1mlqMqj3HfYMjCWVCzgEWWIOUr60v7NS4M1XOx3
	 uRqhl4c8Q5AXvRvXFg6FimXHACvTbSVumiBcjH5V4zPGaLgKWtH9iy6LUarR2hSGXB
	 fA2m70LDrAzIYhVXDvA5vmjOUSGntSS+GVcHXL2I1xoW+Kpw6cA4ddRAkdO9DDbmRY
	 E2qY5LEUXEIJQCPj+m3YA6kHimAGg9JIiS1w2eje59Mgafs5DAmTjqqWU9gfsx/2P+
	 UCFyJufdB/0wh2CSe4MD16KzYEcS2EINBh4m7Vsqa6xxi44MqrrqG+9DKt/GD7qWPa
	 Vo7j9040ydNVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/7] selftests: net: add scaffolding for Netlink tests in Python
Date: Mon,  1 Apr 2024 18:05:15 -0700
Message-ID: <20240402010520.1209517-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add glue code for accessing the YNL library which lives under
tools/net and YAML spec files from under Documentation/.
Automatically figure out if tests are run in tree or not.
Since we'll want to use this library both from net and
drivers/net test targets make the library a target as well,
and automatically include it when net or drivers/net are
included. Making net/lib a target ensures that we end up
with only one copy of it, and saves us some path guessing.

Add a tiny bit of formatting support to be able to output KTAP
from the start.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/Makefile              |  7 ++
 tools/testing/selftests/net/lib/Makefile      |  8 ++
 .../testing/selftests/net/lib/py/__init__.py  |  6 ++
 tools/testing/selftests/net/lib/py/consts.py  |  9 ++
 tools/testing/selftests/net/lib/py/ksft.py    | 96 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   | 47 +++++++++
 tools/testing/selftests/net/lib/py/ynl.py     | 49 ++++++++++
 7 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/Makefile
 create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/net/lib/py/consts.py
 create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
 create mode 100644 tools/testing/selftests/net/lib/py/utils.py
 create mode 100644 tools/testing/selftests/net/lib/py/ynl.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..0cffdfb4b116 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -116,6 +116,13 @@ TARGETS += zram
 TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
+# Networking tests want the net/lib target, include it automatically
+ifneq ($(filter net ,$(TARGETS)),)
+ifeq ($(filter net/lib,$(TARGETS)),)
+	override TARGETS := $(TARGETS) net/lib
+endif
+endif
+
 # User can optionally provide a TARGETS skiplist.  By default we skip
 # BPF since it has cutting edge build time dependencies which require
 # more effort to install.
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
new file mode 100644
index 000000000000..5730682aeffb
--- /dev/null
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_FILES := ../../../../../Documentation/netlink/s*
+TEST_FILES += ../../../../net/*
+
+TEST_INCLUDES := $(wildcard py/*.py)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
new file mode 100644
index 000000000000..81a8d14b68f0
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from .ksft import *
+from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
+from .consts import KSRC
+from .utils import *
diff --git a/tools/testing/selftests/net/lib/py/consts.py b/tools/testing/selftests/net/lib/py/consts.py
new file mode 100644
index 000000000000..f518ce79d82c
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/consts.py
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../..").resolve()
+KSRC = (Path(__file__).parent / "../../../../../..").resolve()
+
+KSFT_MAIN_NAME = Path(sys.argv[0]).with_suffix("").name
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
new file mode 100644
index 000000000000..7c296fe5e438
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import builtins
+from .consts import KSFT_MAIN_NAME
+
+KSFT_RESULT = None
+
+
+class KsftSkipEx(Exception):
+    pass
+
+
+class KsftXfailEx(Exception):
+    pass
+
+
+def ksft_pr(*objs, **kwargs):
+    print("#", *objs, **kwargs)
+
+
+def ksft_eq(a, b, comment=""):
+    global KSFT_RESULT
+    if a != b:
+        KSFT_RESULT = False
+        ksft_pr("Check failed", a, "!=", b, comment)
+
+
+def ksft_true(a, comment=""):
+    global KSFT_RESULT
+    if not a:
+        KSFT_RESULT = False
+        ksft_pr("Check failed", a, "does not eval to True", comment)
+
+
+def ksft_in(a, b, comment=""):
+    global KSFT_RESULT
+    if a not in b:
+        KSFT_RESULT = False
+        ksft_pr("Check failed", a, "not in", b, comment)
+
+
+def ksft_ge(a, b, comment=""):
+    global KSFT_RESULT
+    if a < b:
+        KSFT_RESULT = False
+        ksft_pr("Check failed", a, "<", b, comment)
+
+
+def ktap_result(ok, cnt=1, case="", comment=""):
+    res = ""
+    if not ok:
+        res += "not "
+    res += "ok "
+    res += str(cnt) + " "
+    res += KSFT_MAIN_NAME
+    if case:
+        res += "." + str(case.__name__)
+    if comment:
+        res += " # " + comment
+    print(res)
+
+
+def ksft_run(cases):
+    totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
+
+    print("KTAP version 1")
+    print("1.." + str(len(cases)))
+
+    global KSFT_RESULT
+    cnt = 0
+    for case in cases:
+        KSFT_RESULT = True
+        cnt += 1
+        try:
+            case()
+        except KsftSkipEx as e:
+            ktap_result(True, cnt, case, comment="SKIP " + str(e))
+            totals['skip'] += 1
+            continue
+        except KsftXfailEx as e:
+            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
+            totals['xfail'] += 1
+            continue
+        except Exception as e:
+            for line in str(e).split('\n'):
+                ksft_pr("Exception|", line)
+            ktap_result(False, cnt, case)
+            totals['fail'] += 1
+            continue
+
+        ktap_result(KSFT_RESULT, cnt, case)
+        totals['pass'] += 1
+
+    print(
+        f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
+    )
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
new file mode 100644
index 000000000000..f0d425731fd4
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import json as _json
+import subprocess
+
+class cmd:
+    def __init__(self, comm, shell=True, fail=True, ns=None, background=False):
+        if ns:
+            if isinstance(ns, NetNS):
+                ns = ns.name
+            comm = f'ip netns exec {ns} ' + comm
+
+        self.stdout = None
+        self.stderr = None
+        self.ret = None
+
+        self.comm = comm
+        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
+                                     stderr=subprocess.PIPE)
+        if not background:
+            self.process(terminate=False, fail=fail)
+
+    def process(self, terminate=True, fail=None):
+        if terminate:
+            self.proc.terminate()
+        stdout, stderr = self.proc.communicate()
+        self.stdout = stdout.decode("utf-8")
+        self.stderr = stderr.decode("utf-8")
+        self.proc.stdout.close()
+        self.proc.stderr.close()
+        self.ret = self.proc.returncode
+
+        if self.proc.returncode != 0 and fail:
+            if len(stderr) > 0 and stderr[-1] == "\n":
+                stderr = stderr[:-1]
+            raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
+
+
+def ip(args, json=None, ns=None):
+    cmd_str = "ip "
+    if json:
+        cmd_str += '-j '
+    cmd_str += args
+    cmd_obj = cmd(cmd_str, ns=ns)
+    if json:
+        return _json.loads(cmd_obj.stdout)
+    return cmd_obj
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
new file mode 100644
index 000000000000..298bbc6b93c5
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+from .consts import KSRC, KSFT_DIR
+from .ksft import ksft_pr, ktap_result
+
+# Resolve paths
+try:
+    if (KSFT_DIR / "kselftest-list.txt").exists():
+        # Running in "installed" selftests
+        tools_full_path = KSFT_DIR
+        SPEC_PATH = KSFT_DIR / "net/lib/specs"
+
+        sys.path.append(tools_full_path.as_posix())
+        from net.lib.ynl.lib import YnlFamily, NlError
+    else:
+        # Running in tree
+        tools_full_path = Path(KSRC) / "tools"
+        SPEC_PATH = Path(KSRC) / "Documentation/netlink/specs"
+
+        sys.path.append(tools_full_path.as_posix())
+        from net.ynl.lib import YnlFamily, NlError
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `ynl` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
+
+#
+# Wrapper classes, loading the right specs
+# Set schema='' to avoid jsonschema validation, it's slow
+#
+class EthtoolFamily(YnlFamily):
+    def __init__(self):
+        super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
+                         schema='')
+
+
+class RtnlFamily(YnlFamily):
+    def __init__(self):
+        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
+                         schema='')
+
+
+class NetdevFamily(YnlFamily):
+    def __init__(self):
+        super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
+                         schema='')
-- 
2.44.0


