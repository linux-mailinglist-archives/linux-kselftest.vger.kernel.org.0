Return-Path: <linux-kselftest+bounces-38780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007CB22A83
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E16A5A42AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C92E92C3;
	Tue, 12 Aug 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9MJsFCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D70288CA5;
	Tue, 12 Aug 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008463; cv=none; b=d7RCfr4cYheZ7km1Qx7NP52MIxZ6DK4BRQIIwCFduJDMlseUYiSjAVqvk3dpEyPE2fC+tvJYxcwZTw3NJWQa2oyC6dO2LjKedD0MdcC41zfXMPH4/8/BJRKiWebOi6ipf6FWqJHUhVQBP69KlG0mZzDoKJ9FQPm4rFhBpxb8slI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008463; c=relaxed/simple;
	bh=/s4QCjNiaG8i2gVPHA9BZYnfZknetpckALmAqKlClZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgH+CCZfk+OegDNPT6fQ0WQvHDdmYRrfRdO/Y9hlLB57mJzM2ayzWptPP9xraMe4pLoCmGQ+7RJWO/zqJCjoAobEKz7d5hsiVZO5UZJ+Cf5gX55E2BzeCYLJzCu98d8cnAbyJYCne/NvpuifIsVF50zEGcNCUeUS9GWyez/8GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9MJsFCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC8BC4CEF0;
	Tue, 12 Aug 2025 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755008463;
	bh=/s4QCjNiaG8i2gVPHA9BZYnfZknetpckALmAqKlClZk=;
	h=From:To:Cc:Subject:Date:From;
	b=U9MJsFCT9wTebQmhAToepOdDQ6mGZBBP5ojKwVeGnmi4BIVTBq916sJPW8VhWZffm
	 brP0Q4zTsosquCk88+8UMPfoG7F8qYtdn9YzjkMuS2FM4pqMFnQZg+/zufLLiAWp5S
	 PS7bgMx4JheqAHjxcnwpH6oI+nE1neTKdFDNnDbwKYRLsWqyC6UZJdVHHPZ2EKA5v0
	 ax5PfDaGvPzcrJ21PKrruvy7CkbE4WMGm1skJQYUw6I1vIC70EbM09KKDpEd2cejOn
	 8qUjbmItr5u16arlzDwj909TkiTcKo08A8WxnwfkHUvagi24/ugvv3EshSWeFHg/IL
	 iRyau49Wa39bg==
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
Subject: [PATCH net-next v2] selftests: drv-net: wait for carrier
Date: Tue, 12 Aug 2025 07:20:54 -0700
Message-ID: <20250812142054.750282-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add an empty __del__
v1: https://lore.kernel.org/20250808225741.1095702-1-kuba@kernel.org

CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 .../selftests/drivers/net/lib/py/env.py       | 41 +++++++++----------
 tools/testing/selftests/net/lib/py/utils.py   | 18 ++++++++
 3 files changed, 39 insertions(+), 22 deletions(-)

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
index 1b8bd648048f..c1f3b608c6d8 100644
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
 
@@ -48,6 +51,22 @@ from .remote import Remote
                 env[pair[0]] = pair[1]
         return ksft_setup(env)
 
+    def __del__(self):
+        pass
+
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
@@ -72,17 +91,6 @@ from .remote import Remote
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
@@ -219,15 +227,6 @@ from .remote import Remote
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


