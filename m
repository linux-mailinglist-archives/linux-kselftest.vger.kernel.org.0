Return-Path: <linux-kselftest+bounces-7891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71658A38ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F4284328
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6E152DFD;
	Fri, 12 Apr 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRXYJ852"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24129152DF2;
	Fri, 12 Apr 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965038; cv=none; b=hB4YwX6zneZu6GdHoprNrE2VmukB3y+VjvOEUFAXNZbCrnkCfXVLK4elgdZ8eHeykuuh5nfVJ+xEaRUI7hn4cuNWxkA9DUckz2MK6VNqs3GcBI+MZpXEoELUseHNgUhFn01N/ehBvcf6w/9N4I5rmWnLudTpQUYRviHdGNNu4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965038; c=relaxed/simple;
	bh=PwHVkxz3nBF0PRBY9R8DIP+LWJ54pS+3zPif8AFoQVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CplciLGxLqS0ZoaajR1LU5lpIwFiTlpI7ITfJv2zBeX14qPSVV+BrX03Alyg3ajxHAfIapIvCSY33+XqStE+Uj45f3iNdXtWfdYMQIMynNmYV6vx1o3eiRKgSLlXcd+TiOYj0qA/YykWqusINmM2z0jbc7fesSEq82lyEkGzeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRXYJ852; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FADC4AF14;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965038;
	bh=PwHVkxz3nBF0PRBY9R8DIP+LWJ54pS+3zPif8AFoQVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRXYJ852u9L7aI0FStuUYOMY+aManO3CSxV4ElCMwSDh5yk2Ca9Nq5pnh0hzrF6uI
	 1atyCwR4GL8IrJo8E24MXN7Qwk9jQDIgEHXQplB707dlLPGmX6oM6PEX4G8MlvhBzG
	 g4n4O6V9aCER1qzbXaa2w+DEGpgF44ltgrVhNnk/5OFonlyrOYsQxnIAmWyc0CDIlr
	 c7uSFYXrS2h7ZRN4+T0aLMFof7toxt1buo9azNp03KYnNchGbzpJrW5qn+xkpoSsPi
	 sH1A5wH2/5LG9TGEpNqW7nP7JxS1buL9Yhdxv32roiFxgxVEn1YexJOiJSJzKN2otp
	 CoDytpHCg+/2Q==
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
Subject: [PATCH net-next 4/5] selftests: drv-net: construct environment for running tests which require an endpoint
Date: Fri, 12 Apr 2024 16:37:04 -0700
Message-ID: <20240412233705.1066444-5-kuba@kernel.org>
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

Nothing surprising here, hopefully. Wrap the variables from
the environment into a class or spawn a netdevsim based env
and pass it to the tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/README.rst  | 31 +++++++
 .../selftests/drivers/net/lib/py/env.py       | 93 ++++++++++++++++++-
 .../testing/selftests/net/lib/py/__init__.py  |  1 +
 tools/testing/selftests/net/lib/py/netns.py   | 31 +++++++
 4 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 5ef7c417d431..ffc15fe5d555 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -23,8 +23,39 @@ Variables can be set in the environment or by creating a net.config
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
+LOCAL_V4, LOCAL_V6, EP_V4, EP_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local and remote (endpoint) IP addresses.
+
+EP_TYPE
+~~~~~~~
+
+Communication method used to run commands on the endpoint.
+Test framework supports using ``netns`` and ``ssh`` channels.
+``netns`` assumes the "remote" interface is part of the same
+host, just moved to the specified netns.
+``ssh`` communicates with remote endpoint over ``ssh`` and ``scp``.
+
+Communication methods are defined by classes in ``lib/py/ep_{name}.py``.
+It should be possible to add a new method without modifying any of
+the framework, by simply adding an appropriately named file to ``lib/py``.
+
+EP_ARGS
+~~~~~~~
+
+Arguments used to construct the communication channel.
+Communication channel dependent::
+
+  for netns - name of the "remote" namespace
+  for ssh - name/address of the remote host
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a081e168f3db..f63be0a72a53 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,7 +4,8 @@ import os
 import shlex
 from pathlib import Path
 from lib.py import ip
-from lib.py import NetdevSimDev
+from lib.py import NetNS, NetdevSimDev
+from .endpoint import Endpoint
 
 
 def _load_env_file(src_path):
@@ -59,3 +60,93 @@ from lib.py import NetdevSimDev
             self._ns = None
 
 
+class NetDrvEpEnv:
+    """
+    Class for an environment with a local device and "remote endpoint"
+    which can be used to send traffic in.
+
+    For local testing it creates two network namespaces and a pair
+    of netdevsim devices.
+    """
+    def __init__(self, src_path):
+
+        self.env = _load_env_file(src_path)
+
+        # Things we try to destroy
+        self.endpoint = None
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
+            self.ep_v4 = self.env.get("EP_V4")
+            self.ep_v6 = self.env.get("EP_V6")
+            ep_type = self.env["EP_TYPE"]
+            ep_args = self.env["EP_ARGS"]
+        else:
+            self.create_local()
+
+            self.dev = self._ns.nsims[0].dev
+
+            self.v4 = "192.0.2.1"
+            self.v6 ="0100::1"
+            self.ep_v4 = "192.0.2.2"
+            self.ep_v6 = "0100::2"
+            ep_type = "netns"
+            ep_args = self._netns.name
+
+        self.endpoint = Endpoint(ep_type, ep_args)
+
+        self.addr = self.v6 if self.v6 else self.v4
+        self.ep_addr = self.ep_v6 if self.ep_v6 else self.ep_v4
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
+        ip(f"   addr add dev {self._ns.nsims[0].ifname} 192.0.2.1/24")
+        ip(f"-6 addr add dev {self._ns.nsims[0].ifname} 0100::1/64 nodad")
+        ip(f"   link set dev {self._ns.nsims[0].ifname} up")
+
+        ip(f"   addr add dev {self._ns_peer.nsims[0].ifname} 192.0.2.2/24", ns=self._netns)
+        ip(f"-6 addr add dev {self._ns_peer.nsims[0].ifname} 0100::2/64 nodad", ns=self._netns)
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
+        if self.endpoint:
+            del self.endpoint
+            self.endpoint = None
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


