Return-Path: <linux-kselftest+bounces-7040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC489628F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FC2874EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CD29427;
	Wed,  3 Apr 2024 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+VvH9EH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE31BDCF;
	Wed,  3 Apr 2024 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111676; cv=none; b=csv86ayWuRpHNV5wiTXO2XqytzxknvKfDm4Ka1UlrefuLs4/1zpv/AinVyTxk5tp31zC8r6OCtv0p3Vy+tTx0l4s070ZgwVjZupbh4UgpwSa/5XjCDRHdnEYGfaYfD5OtAT8Yi+ZKC2XtaosEPoPM1G+jQR9i6hbRIhZQ6yO1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111676; c=relaxed/simple;
	bh=SrQYBq6TkF/h5ZaCRUpkXIQLGRMN7pTj+sSVp3tGvtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEQSQ7CtKrwR8Aq1/6TGgUPCM6Zajvgcewe8FQ43CQZtwg8rZcK3fXr0lIOODvy5IJEjE69Pa4kwrL5MCoc7KEW9HLcrXjOBDwTm6Uencv06437Kaf8LfU/kFI0g4UVNHnEN/cg+7SvcrlvPJJgbJxJJaxKvOWQh3xfSliAwoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+VvH9EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2EEC433B1;
	Wed,  3 Apr 2024 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111676;
	bh=SrQYBq6TkF/h5ZaCRUpkXIQLGRMN7pTj+sSVp3tGvtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+VvH9EHnsPNikdKnLeGicvDMhlLN/Ag4lay3B00s6i59hBwWueFjnBlcBP9JQl+p
	 fdBAY5CWq1uDoC1roOcmCAR038J3G5EameNKiVPiYgPrmMvN1v7CZo4NInirEt/4AT
	 SCgWI7WDnMcChS9tcH5ikGqAq5tmpkncHGGTFCxSzJEUR8NeotO0YHSswFq6K0TIN4
	 kf5Qo1tWpyz/ZdWmtq8IgzSmwA8uVGrQU+UoZXik5knAqbOijq7M8GfNHtXN4ykpE5
	 NE6Fdcaqh0fqCtxNBqcn+/sBFNdQiY+IKfKqs4b8nfZYj0by7QiZK8O8SrrZCOG0li
	 zy5b7wm0uU+HA==
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
Subject: [PATCH net-next v2 6/7] selftests: drivers: add scaffolding for Netlink tests in Python
Date: Tue,  2 Apr 2024 19:34:25 -0700
Message-ID: <20240403023426.1762996-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drivers/net as a target for mixed-use tests.
The setup is expected to work similarly to the forwarding tests.
Since we only need one interface (unlike forwarding tests)
read the target device name from NETIF. If not present we'll
try to run the test against netdevsim.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - mark regex as r""
 - add support of using env as with
---
 tools/testing/selftests/Makefile              |   3 +-
 tools/testing/selftests/drivers/net/Makefile  |   7 ++
 .../testing/selftests/drivers/net/README.rst  |  30 +++++
 .../selftests/drivers/net/lib/py/__init__.py  |  17 +++
 .../selftests/drivers/net/lib/py/env.py       |  52 ++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/nsim.py    | 118 ++++++++++++++++++
 7 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/README.rst
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/env.py
 create mode 100644 tools/testing/selftests/net/lib/py/nsim.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f533eb7054fe..6dab886d6f7a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -17,6 +17,7 @@ TARGETS += devices
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
+TARGETS += drivers/net
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
 TARGETS += dt
@@ -117,7 +118,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net,$(TARGETS)),)
+ifneq ($(filter net drivers/net,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
new file mode 100644
index 000000000000..379cdb1960a7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_INCLUDES := $(wildcard lib/py/*.py)
+
+TEST_PROGS := stats.py
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
new file mode 100644
index 000000000000..5ef7c417d431
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -0,0 +1,30 @@
+Running tests
+=============
+
+Tests are executed within kselftest framework like any other tests.
+By default tests execute against software drivers such as netdevsim.
+All tests must support running against a real device (SW-only tests
+should instead be placed in net/ or drivers/net/netdevsim, HW-only
+tests in drivers/net/hw).
+
+Set appropriate variables to point the tests at a real device.
+
+Variables
+=========
+
+Variables can be set in the environment or by creating a net.config
+file in the same directory as this README file. Example::
+
+  $ NETIF=eth0 ./some_test.sh
+
+or::
+
+  $ cat tools/testing/selftests/drivers/net/net.config
+  # Variable set in a file
+  NETIF=eth0
+
+NETIF
+~~~~~
+
+Name of the netdevice against which the test should be executed.
+When empty or not set software devices will be used.
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
new file mode 100644
index 000000000000..4653dffcd962
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
+
+from .env import *
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
new file mode 100644
index 000000000000..e1abe9491daf
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import shlex
+from pathlib import Path
+from lib.py import ip
+from lib.py import NetdevSimDev
+
+class NetDrvEnv:
+    def __init__(self, src_path):
+        self._ns = None
+
+        self.env = os.environ.copy()
+        self._load_env_file(src_path)
+
+        if 'NETIF' in self.env:
+            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
+        else:
+            self._ns = NetdevSimDev()
+            self.dev = self._ns.nsims[0].dev
+        self.ifindex = self.dev['ifindex']
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        """
+        __exit__ gets called at the end of a "with" block.
+        """
+        self.__del__()
+
+    def __del__(self):
+        if self._ns:
+            self._ns.remove()
+            self._ns = None
+
+    def _load_env_file(self, src_path):
+        src_dir = Path(src_path).parent.resolve()
+        if not (src_dir / "net.config").exists():
+            return
+
+        lexer = shlex.shlex(open((src_dir / "net.config").as_posix(), 'r').read())
+        k = None
+        for token in lexer:
+            if k is None:
+                k = token
+                self.env[k] = ""
+            elif token == "=":
+                pass
+            else:
+                self.env[k] = token
+                k = None
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 7823b5c1f8d7..ded7102df18a 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,5 +2,6 @@
 
 from .consts import KSRC
 from .ksft import *
+from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
new file mode 100644
index 000000000000..25ae0d081788
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+import os
+import random
+import re
+import time
+from .utils import cmd, ip
+
+
+class NetdevSim:
+    """
+    Class for netdevsim netdevice and its attributes.
+    """
+
+    def __init__(self, nsimdev, port_index, ifname, ns=None):
+        # In case udev renamed the netdev to according to new schema,
+        # check if the name matches the port_index.
+        nsimnamere = re.compile(r"eni\d+np(\d+)")
+        match = nsimnamere.match(ifname)
+        if match and int(match.groups()[0]) != port_index + 1:
+            raise Exception("netdevice name mismatches the expected one")
+
+        self.ifname = ifname
+        self.nsimdev = nsimdev
+        self.port_index = port_index
+        self.ns = ns
+        self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
+        ret = ip("-j link show dev %s" % ifname, ns=ns)
+        self.dev = json.loads(ret.stdout)[0]
+
+    def dfs_write(self, path, val):
+        self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
+
+
+class NetdevSimDev:
+    """
+    Class for netdevsim bus device and its attributes.
+    """
+    @staticmethod
+    def ctrl_write(path, val):
+        fullpath = os.path.join("/sys/bus/netdevsim/", path)
+        with open(fullpath, "w") as f:
+            f.write(val)
+
+    def dfs_write(self, path, val):
+        fullpath = os.path.join(f"/sys/kernel/debug/netdevsim/netdevsim{self.addr}/", path)
+        with open(fullpath, "w") as f:
+            f.write(val)
+
+    def __init__(self, port_count=1, ns=None):
+        # nsim will spawn in init_net, we'll set to actual ns once we switch it the.sre
+        self.ns = None
+
+        if not os.path.exists("/sys/bus/netdevsim"):
+            cmd("modprobe netdevsim")
+
+        addr = random.randrange(1 << 15)
+        while True:
+            try:
+                self.ctrl_write("new_device", "%u %u" % (addr, port_count))
+            except OSError as e:
+                if e.errno == errno.ENOSPC:
+                    addr = random.randrange(1 << 15)
+                    continue
+                raise e
+            break
+        self.addr = addr
+
+        # As probe of netdevsim device might happen from a workqueue,
+        # so wait here until all netdevs appear.
+        self.wait_for_netdevs(port_count)
+
+        if ns:
+            cmd(f"devlink dev reload netdevsim/netdevsim{addr} netns {ns.name}")
+            self.ns = ns
+
+        cmd("udevadm settle", ns=self.ns)
+        ifnames = self.get_ifnames()
+
+        self.dfs_dir = "/sys/kernel/debug/netdevsim/netdevsim%u/" % addr
+
+        self.nsims = []
+        for port_index in range(port_count):
+            self.nsims.append(NetdevSim(self, port_index, ifnames[port_index],
+                                        ns=ns))
+
+    def get_ifnames(self):
+        ifnames = []
+        listdir = cmd(f"ls /sys/bus/netdevsim/devices/netdevsim{self.addr}/net/",
+                      ns=self.ns).stdout.split()
+        for ifname in listdir:
+            ifnames.append(ifname)
+        ifnames.sort()
+        return ifnames
+
+    def wait_for_netdevs(self, port_count):
+        timeout = 5
+        timeout_start = time.time()
+
+        while True:
+            try:
+                ifnames = self.get_ifnames()
+            except FileNotFoundError as e:
+                ifnames = []
+            if len(ifnames) == port_count:
+                break
+            if time.time() < timeout_start + timeout:
+                continue
+            raise Exception("netdevices did not appear within timeout")
+
+    def remove(self):
+        self.ctrl_write("del_device", "%u" % (self.addr, ))
+
+    def remove_nsim(self, nsim):
+        self.nsims.remove(nsim)
+        self.ctrl_write("devices/netdevsim%u/del_port" % (self.addr, ),
+                        "%u" % (nsim.port_index, ))
-- 
2.44.0


