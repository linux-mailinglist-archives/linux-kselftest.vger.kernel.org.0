Return-Path: <linux-kselftest+bounces-8526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E88AB90F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6172D1C20FA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EC79DE;
	Sat, 20 Apr 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQqJzH1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D378FC1C;
	Sat, 20 Apr 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581562; cv=none; b=qbUJXNEY/KJOt5LWRW8Kfj/D39SKR5r7EI9tougk79uJE9Slz0cLrYZetueT4c06eF5kEBRdPx6FZxtmwUUNDVf0E0LIhDyVsZ238EQlolgmm2/xMZxnH56e5SuTqrd3VxoOroFONcvOoOtFWaYANqH80SV3mKQ3J4qEyOYCwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581562; c=relaxed/simple;
	bh=LWouE9X7rzpJYEbBLAu3hDxweSMYx1hX1X8QWpU0+sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d//L0b/TKnZiGorbbGaTAFjKSkryqoBpOyQtIymbd1TbOU1MOWZ3Mqj4jILO6r5NbGQ4B1NwGH6nN87hovuO2CL9OfCcEHXYX1R7rR5xtCNkopiqFwCCpI9h9jS+czYVcpBSVC7klFuvqwNv3yzLlHP2yX5sH/RDZlFff33u8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQqJzH1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8057C32781;
	Sat, 20 Apr 2024 02:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581562;
	bh=LWouE9X7rzpJYEbBLAu3hDxweSMYx1hX1X8QWpU0+sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQqJzH1NahRwJr4KdnlGDg4kLPSpeI4Ubxzpa4OSWDaNpaOeb3g63oSdkh2nl+y3p
	 sEbBuLgpiTzdLhyjv/MgJtsF9AMOpVZJYwFKInVOjEYFJ9Qw84AsKxtJtMuTYjyAqR
	 M7yPbe6HkAWPGREpAUY03vIvukRI2mPMrEcERkD8tnmpfdsBYvAAwd8RzHaF5FRn9r
	 0hEG7tryPe/ph8gUBfrZoY/PIv9M28nldmiu3e0tHHRN/+jCXHxXBFtzbk7IasZswp
	 XxUbLrSIi3bA+ep3S+MIHJJv81ag/f/r+bsVs9VMYXEWJivXwIZ5Q4Nwd+eXidqyUg
	 SJn58zwag3Evg==
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
Subject: [PATCH net-next v5 3/7] selftests: drv-net: construct environment for running tests which require an endpoint
Date: Fri, 19 Apr 2024 19:52:33 -0700
Message-ID: <20240420025237.3309296-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025237.3309296-1-kuba@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing surprising here, hopefully. Wrap the variables from
the environment into a class or spawn a netdevsim based env
and pass it to the tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/README.rst  | 33 +++++++
 .../selftests/drivers/net/lib/py/env.py       | 98 ++++++++++++++++++-
 .../testing/selftests/net/lib/py/__init__.py  |  1 +
 tools/testing/selftests/net/lib/py/netns.py   | 31 ++++++
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 5ef7c417d431..0cbab33dad1f 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -23,8 +23,41 @@ Variables can be set in the environment or by creating a net.config
   # Variable set in a file
   NETIF=eth0
 
+Please note that the config parser is very simple, if there are
+any non-alphanumeric characters in the value it needs to be in
+double quotes.
+
 NETIF
 ~~~~~
 
 Name of the netdevice against which the test should be executed.
 When empty or not set software devices will be used.
+
+LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local and remote endpoint IP addresses.
+
+REMOTE_TYPE
+~~~~~~~~~~~
+
+Communication method used to run commands on the remote endpoint.
+Test framework has built-in support for ``netns`` and ``ssh`` channels.
+``netns`` assumes the "remote" interface is part of the same
+host, just moved to the specified netns.
+``ssh`` communicates with remote endpoint over ``ssh`` and ``scp``.
+Using persistent SSH connections is strongly encouraged to avoid
+the latency of SSH connection setup on every command.
+
+Communication methods are defined by classes in ``lib/py/remote_{name}.py``.
+It should be possible to add a new method without modifying any of
+the framework, by simply adding an appropriately named file to ``lib/py``.
+
+REMOTE_ARGS
+~~~~~~~~~~~
+
+Arguments used to construct the communication channel.
+Communication channel dependent::
+
+  for netns - name of the "remote" namespace
+  for ssh - name/address of the remote host
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a081e168f3db..579c5b34e6fd 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,7 +4,8 @@ import os
 import shlex
 from pathlib import Path
 from lib.py import ip
-from lib.py import NetdevSimDev
+from lib.py import NetNS, NetdevSimDev
+from .remote import Remote
 
 
 def _load_env_file(src_path):
@@ -59,3 +60,98 @@ from lib.py import NetdevSimDev
             self._ns = None
 
 
+class NetDrvEpEnv:
+    """
+    Class for an environment with a local device and "remote endpoint"
+    which can be used to send traffic in.
+
+    For local testing it creates two network namespaces and a pair
+    of netdevsim devices.
+    """
+
+    # Network prefixes used for local tests
+    nsim_v4_pfx = "192.0.2."
+    nsim_v6_pfx = "2001:db8::"
+
+    def __init__(self, src_path):
+
+        self.env = _load_env_file(src_path)
+
+        # Things we try to destroy
+        self.remote = None
+        # These are for local testing state
+        self._netns = None
+        self._ns = None
+        self._ns_peer = None
+
+        if "NETIF" in self.env:
+            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
+
+            self.v4 = self.env.get("LOCAL_V4")
+            self.v6 = self.env.get("LOCAL_V6")
+            self.remote_v4 = self.env.get("REMOTE_V4")
+            self.remote_v6 = self.env.get("REMOTE_V6")
+            kind = self.env["REMOTE_TYPE"]
+            args = self.env["REMOTE_ARGS"]
+        else:
+            self.create_local()
+
+            self.dev = self._ns.nsims[0].dev
+
+            self.v4 = self.nsim_v4_pfx + "1"
+            self.v6 = self.nsim_v6_pfx + "1"
+            self.remote_v4 = self.nsim_v4_pfx + "2"
+            self.remote_v6 = self.nsim_v6_pfx + "2"
+            kind = "netns"
+            args = self._netns.name
+
+        self.remote = Remote(kind, args, src_path)
+
+        self.addr = self.v6 if self.v6 else self.v4
+        self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
+
+        self.ifname = self.dev['ifname']
+        self.ifindex = self.dev['ifindex']
+
+    def create_local(self):
+        self._netns = NetNS()
+        self._ns = NetdevSimDev()
+        self._ns_peer = NetdevSimDev(ns=self._netns)
+
+        with open("/proc/self/ns/net") as nsfd0, \
+             open("/var/run/netns/" + self._netns.name) as nsfd1:
+            ifi0 = self._ns.nsims[0].ifindex
+            ifi1 = self._ns_peer.nsims[0].ifindex
+            NetdevSimDev.ctrl_write('link_device',
+                                    f'{nsfd0.fileno()}:{ifi0} {nsfd1.fileno()}:{ifi1}')
+
+        ip(f"   addr add dev {self._ns.nsims[0].ifname} {self.nsim_v4_pfx}1/24")
+        ip(f"-6 addr add dev {self._ns.nsims[0].ifname} {self.nsim_v6_pfx}1/64 nodad")
+        ip(f"   link set dev {self._ns.nsims[0].ifname} up")
+
+        ip(f"   addr add dev {self._ns_peer.nsims[0].ifname} {self.nsim_v4_pfx}2/24", ns=self._netns)
+        ip(f"-6 addr add dev {self._ns_peer.nsims[0].ifname} {self.nsim_v6_pfx}2/64 nodad", ns=self._netns)
+        ip(f"   link set dev {self._ns_peer.nsims[0].ifname} up", ns=self._netns)
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
+        if self._ns_peer:
+            self._ns_peer.remove()
+            self._ns_peer = None
+        if self._netns:
+            del self._netns
+            self._netns = None
+        if self.remote:
+            del self.remote
+            self.remote = None
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index ded7102df18a..b6d498d125fe 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,6 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
+from .netns import NetNS
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
new file mode 100644
index 000000000000..ecff85f9074f
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from .utils import ip
+import random
+import string
+
+
+class NetNS:
+    def __init__(self, name=None):
+        if name:
+            self.name = name
+        else:
+            self.name = ''.join(random.choice(string.ascii_lowercase) for _ in range(8))
+        ip('netns add ' + self.name)
+
+    def __del__(self):
+        if self.name:
+            ip('netns del ' + self.name)
+            self.name = None
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        self.__del__()
+
+    def __str__(self):
+        return self.name
+
+    def __repr__(self):
+        return f"NetNS({self.name})"
-- 
2.44.0


