Return-Path: <linux-kselftest+bounces-8388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C98AA5F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471ED1C20D69
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EE7D408;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgnBjMH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A657BB07;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483533; cv=none; b=EJ4atU7o5NIk0kQN/GnXNawUcKQy9I5rYvuvjhLmUeo+7QYZ/f/FKfwCQp48tNyPKivXftjVI5vLoVcepn5swOI0yIqfP+OnszaT0PhKodLdqU3/iNnfA5SxzhdYkJ3GDAWIG8U5ybsp3LhE6L5GwW7cqPmfFV/H7YkELBEq3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483533; c=relaxed/simple;
	bh=w3MXqPbZyYCxxCj3daodZExLko5+c/ZSVMOfwTMEBwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWc7fkOuxueiSgB7HquwHmNLR5xwqhORk/1rtF2+UD6m6npB1PYzSWJsKG/hLfcFPGVo6fCXerJBGVYFEyis4JdkJqMbo0V6Lcf++Hl2YutrhlQiD8XNEvmJV9+Lk2CpFevPTUwXINtvZYYgJSx3XyAabtGcyOXOjSjWEp3a9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgnBjMH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C16DC4AF08;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483533;
	bh=w3MXqPbZyYCxxCj3daodZExLko5+c/ZSVMOfwTMEBwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgnBjMH+Qa7BNAb+XgrVJBSib0YRKHLSOCXeJD34At6VxdkdPzu9C3nNPIW9vXm0b
	 1aS3+u/5ZOcD675cRyCmCnEddHn/doTnfoxqrK7STXCO6oyRpOKduWyu0uMbAR0XMn
	 ipcDEkGcIXLBwNhqCsHkAqxNM2UJ/b59nxQe+Z37PsfBzxqWKJWU2Q3n7PxISsMH93
	 hjg+vz09uH9cVb5DfZSKh7lu+rzGpPuYLiMye1uFaUsGGvWHM+ZiUVMU+okwgP3YPa
	 nzmEjGyc+rh8wRZ9Ic6IwTzXmEio5oXP83Fa9SVU6tSuPuPeaDSaDqCMyTINsmLmOo
	 ZzHaRufsupd0g==
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
Subject: [PATCH net-next v4 6/7] selftests: drv-net: add a TCP ping test case (and useful helpers)
Date: Thu, 18 Apr 2024 16:38:43 -0700
Message-ID: <20240418233844.2762396-7-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418233844.2762396-1-kuba@kernel.org>
References: <20240418233844.2762396-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More complex tests often have to spawn a background process,
like a server which will respond to requests or tcpdump.

Add support for creating such processes using the with keyword:

  with bkg("my-daemon", ..):
     # my-daemon is alive in this block

My initial thought was to add this support to cmd() directly
but it runs the command in the constructor, so by the time
we __enter__ it's too late to make sure we used "background=True".

Second useful helper transplanted from net_helper.sh is
wait_port_listen().

The test itself uses socat, which insists on v6 addresses
being wrapped in [], it's not the only command which requires
this format, so add the wrapped address to env. The hope
is to save test code from checking if address is v6.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       |  4 +++
 tools/testing/selftests/drivers/net/ping.py   | 24 ++++++++++++-
 tools/testing/selftests/net/lib/py/utils.py   | 35 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 579c5b34e6fd..2f62270d59fa 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -110,6 +110,10 @@ from .remote import Remote
         self.addr = self.v6 if self.v6 else self.v4
         self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
 
+        # Bracketed addresses, some commands need IPv6 to be inside []
+        self.baddr = f"[{self.v6}]" if self.v6 else self.v4
+        self.remote_baddr = f"[{self.remote_v6}]" if self.remote_v6 else self.remote_v4
+
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 9f65a0764aab..15a0bdcb46e2 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import random
+
 from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq
 from lib.py import NetDrvEpEnv
-from lib.py import cmd
+from lib.py import bkg, cmd, wait_port_listen
 
 
 def test_v4(cfg) -> None:
@@ -16,6 +19,25 @@ from lib.py import cmd
     cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
 
 
+def test_tcp(cfg) -> None:
+    port = random.randrange(1024 + (1 << 15))
+
+    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", exit_wait=True) as nc:
+        wait_port_listen(port)
+
+        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
+            shell=True, host=cfg.remote)
+    ksft_eq(nc.stdout.strip(), "ping")
+
+    port = random.randrange(1024 + (1 << 15))
+    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", host=cfg.remote,
+             exit_wait=True) as nc:
+        wait_port_listen(port, host=cfg.remote)
+
+        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
+    ksft_eq(nc.stdout.strip(), "ping")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 7347d0c0ff05..92d9078c164a 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import json as _json
+import re
 import subprocess
+import time
+
 
 class cmd:
     def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
@@ -38,6 +41,20 @@ import subprocess
                             (self.proc.args, stdout, stderr))
 
 
+class bkg(cmd):
+    def __init__(self, comm, shell=True, fail=True, ns=None, host=None,
+                 exit_wait=False):
+        super().__init__(comm, background=True,
+                         shell=shell, fail=fail, ns=ns, host=host)
+        self.terminate = not exit_wait
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        return self.process(terminate=self.terminate)
+
+
 def ip(args, json=None, ns=None, host=None):
     cmd_str = "ip "
     if json:
@@ -47,3 +64,21 @@ import subprocess
     if json:
         return _json.loads(cmd_obj.stdout)
     return cmd_obj
+
+
+def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
+    end = time.monotonic() + deadline
+
+    pattern = f":{port:04X} .* "
+    if proto == "tcp": # for tcp protocol additionally check the socket state
+        pattern += "0A"
+    pattern = re.compile(pattern)
+
+    while True:
+        data = cmd(f'cat /proc/net/{proto}*', ns=ns, host=host, shell=True).stdout
+        for row in data.split("\n"):
+            if pattern.search(row):
+                return
+        if time.monotonic() > end:
+            raise Exception("Waiting for port listen timed out")
+        time.sleep(sleep)
-- 
2.44.0


