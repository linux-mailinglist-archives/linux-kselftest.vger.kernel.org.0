Return-Path: <linux-kselftest+bounces-38615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C617B1F128
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1781AA7146
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77621D5BB;
	Fri,  8 Aug 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez5v7Hpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C151DA3D;
	Fri,  8 Aug 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693866; cv=none; b=Dhaa/t2A9osFo8W+Tz1fZjaB71ZdUn5Zd3PUApxNA1V1vouzkUwi1IterqYpjuTmwLUKhgPUtY19VWI8oFsvmmv4pS5nAvazyNW3XwcvwhkWJKC7IRB/byYQjjpnGBSoU89Y9J3QgIotvKjK7qiCqV8ng6uhUtIzJQ1CDUJqnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693866; c=relaxed/simple;
	bh=j0BDuL0kGl5vPuO/3gPxBSPP4Xtey+36gzwy1/eqKjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttBCjH4hW2eP2Yz446xak9qV2Vrfr5/JTLGuyZXfRDPPm8rWT0Hs7fREVo7uS0zzv4Tv8zEmc3N9HtnsjaEKDpWv/suwerlSXaLaccNKaG+zSylb0TKg1iR+XGVIXY6BySM90kfek5XDNk2+/fNtWsPAOYdosFPzqpdUAz62PUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez5v7Hpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC83C4CEED;
	Fri,  8 Aug 2025 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754693866;
	bh=j0BDuL0kGl5vPuO/3gPxBSPP4Xtey+36gzwy1/eqKjc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ez5v7HpzRAv5xCVreCAnDk8IxS/R0uLYMHquK7ZVlfOTWFBAuZ7U4rERiDvtKAv/T
	 Yl64OmF3cXIt7duB/CpYoF0P42QbgQsNIEEdv4MetfB8W2ZlydaVYUjLiYYcpYyLc+
	 LUKhBAo1sNj0qX9gpHg15lZjljpyAMfyZ7uE1Yt8Z6fLefhqVwnikdda8357jvkMo8
	 dJW4Unc2XugJGXQ31tEVaJeqpP6G2vsoww0irBUNmsPUwfta8xiZso7zVV6fFGMoHB
	 jl83Bgr5foe/euUK6ZeY9xBi8R4V4YKUsHe9cJofC6tKvRVmetQhdNfRMmc2Xd+P+1
	 Y8i9PbBkLFxWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: drv-net: wait for carrier
Date: Fri,  8 Aug 2025 15:57:41 -0700
Message-ID: <20250808225741.1095702-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On fast machines the tests run in quick succession so even
when tests clean up after themselves the carrier may need
some time to come back.

Specifically in NIPA when ping.py runs right after netpoll_basic.py
the first ping command fails.

Since the context manager callbacks are now common NetDrvEpEnv
gets an ip link up call as well.

Fixes: b4db9f840283 ("selftests: drivers: add scaffolding for Netlink tests in Python")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 .../selftests/drivers/net/lib/py/env.py       | 38 +++++++++----------
 tools/testing/selftests/net/lib/py/utils.py   | 18 +++++++++
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8711c67ad658..a07b56a75c8a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,7 +15,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, tool, wait_port_listen
+        fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 1b8bd648048f..1de63734ddec 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,7 +4,7 @@ import os
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
-from lib.py import ksft_setup
+from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
@@ -25,6 +25,9 @@ from .remote import Remote
 
         self.env = self._load_env_file()
 
+        # Following attrs must be set be inheriting classes
+        self.dev = None
+
     def _load_env_file(self):
         env = os.environ.copy()
 
@@ -48,6 +51,19 @@ from .remote import Remote
                 env[pair[0]] = pair[1]
         return ksft_setup(env)
 
+    def __enter__(self):
+        ip(f"link set dev {self.dev['ifname']} up")
+        wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
+                  lambda x: x.strip() == "1")
+
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        """
+        __exit__ gets called at the end of a "with" block.
+        """
+        self.__del__()
+
 
 class NetDrvEnv(NetDrvEnvBase):
     """
@@ -72,17 +88,6 @@ from .remote import Remote
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
-    def __enter__(self):
-        ip(f"link set dev {self.dev['ifname']} up")
-
-        return self
-
-    def __exit__(self, ex_type, ex_value, ex_tb):
-        """
-        __exit__ gets called at the end of a "with" block.
-        """
-        self.__del__()
-
     def __del__(self):
         if self._ns:
             self._ns.remove()
@@ -219,15 +224,6 @@ from .remote import Remote
             raise Exception("Can't resolve remote interface name, multiple interfaces match")
         return v6[0]["ifname"] if v6 else v4[0]["ifname"]
 
-    def __enter__(self):
-        return self
-
-    def __exit__(self, ex_type, ex_value, ex_tb):
-        """
-        __exit__ gets called at the end of a "with" block.
-        """
-        self.__del__()
-
     def __del__(self):
         if self._ns:
             self._ns.remove()
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index f395c90fb0f1..c42bffea0d87 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -249,3 +249,21 @@ global_defer_queue = []
         if time.monotonic() > end:
             raise Exception("Waiting for port listen timed out")
         time.sleep(sleep)
+
+
+def wait_file(fname, test_fn, sleep=0.005, deadline=5, encoding='utf-8'):
+    """
+    Wait for file contents on the local system to satisfy a condition.
+    test_fn() should take one argument (file contents) and return whether
+    condition is met.
+    """
+    end = time.monotonic() + deadline
+
+    with open(fname, "r", encoding=encoding) as fp:
+        while True:
+            if test_fn(fp.read()):
+                break
+            fp.seek(0)
+            if time.monotonic() > end:
+                raise TimeoutError("Wait for file contents failed", fname)
+            time.sleep(sleep)
-- 
2.50.1


