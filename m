Return-Path: <linux-kselftest+bounces-8285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837D8A8F34
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F181F21AE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB73171085;
	Wed, 17 Apr 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYKp4VNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845486642;
	Wed, 17 Apr 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395520; cv=none; b=qZAENB8kkozdTV930xA7oeSiQEWuogD9xF7OgK3UsR2sLlgMA9fECub9rbYY5eI22wdvTq2AxuGGH9euyPPKk4eULu2tDCqoDoVRDBqax+JWqfDgDV8fdefijuEK7Bnr8f2H7+JtpFv5lfn+cxr/hI83ZmtiRoOOxwI9Xfssy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395520; c=relaxed/simple;
	bh=DC11VmWV/vCJfXR7IdGU4BMhT5O7Y8zbY+ZoT49PZoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a42VvmoAMD9jt0qn0nsHd3nYr6huD3N744R9zk1tAl3h0cSO/POHssr/axhau3hYryettH9IvLtfuRXd8/pUzxJkmWV0GlbXuyvhEh7PEw4+i1FbbhmEX7uhw0hngci2kztgegkr+5sbHXorX/7sSiP2ANU9K2zGBhLH8r1HDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYKp4VNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A0CC3277B;
	Wed, 17 Apr 2024 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395519;
	bh=DC11VmWV/vCJfXR7IdGU4BMhT5O7Y8zbY+ZoT49PZoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYKp4VNS2lMzTZfAND/qnEcsUcBot1CElx3m5m9+yNXZD4QK25sDKMD56LJCAKxfR
	 z+Hr87ta/KRr0CMr7ozsR9sh9E4dNOORsD+CrUaRDhXoBro/kzGvdR1CZ9r5zhWM/f
	 1+fZKm0QJ/nLGjdHvIQboeSEQDURhx9J1d+JpLeLFyG7FpMRtkdL1n1fA9vMhwVB6J
	 3/QmOmH6W1dvt0pVoM9iGgbkBTObxu+9fXJ05Eu+NWfAJSqPj09+u0qeGEED4txbcg
	 yodAQryiURTx0kVyThQj0aP7OE9FW0iQfZb6vfXvMIqHyLQ9Cyx4RPqScCzhaVScTR
	 g/TK0wsJ/BJgA==
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
Subject: [PATCH net-next v3 8/8] selftests: drv-net: add a TCP ping test case (and useful helpers)
Date: Wed, 17 Apr 2024 16:11:46 -0700
Message-ID: <20240417231146.2435572-9-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/ping.py | 24 +++++++++++++--
 tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 58aefd3e740f..8532e3be72ba 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_exit, KsftXfailEx
+import random
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, KsftXfailEx
 from lib.py import NetDrvEpEnv
-from lib.py import cmd
+from lib.py import bkg, cmd, wait_port_listen
 
 
 def test_v4(cfg) -> None:
@@ -22,6 +25,23 @@ from lib.py import cmd
     cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
 
 
+def test_tcp(cfg) -> None:
+    port = random.randrange(1024 + (1 << 15))
+    with bkg(f"nc -l {cfg.addr} {port}") as nc:
+        wait_port_listen(port)
+
+        cmd(f"echo ping | nc {cfg.addr} {port}",
+            shell=True, host=cfg.remote)
+    ksft_eq(nc.stdout.strip(), "ping")
+
+    port = random.randrange(1024 + (1 << 15))
+    with bkg(f"nc -l {cfg.remote_addr} {port}", host=cfg.remote) as nc:
+        wait_port_listen(port, host=cfg.remote)
+
+        cmd(f"echo ping | nc {cfg.remote_addr} {port}", shell=True)
+    ksft_eq(nc.stdout.strip(), "ping")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index e80fea9f6562..6bacdc99d21b 100644
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
@@ -38,6 +41,18 @@ import subprocess
                             (self.proc.args, stdout, stderr))
 
 
+class bkg(cmd):
+    def __init__(self, comm, shell=True, fail=True, ns=None, host=None):
+        super().__init__(comm, background=True,
+                         shell=shell, fail=fail, ns=ns, host=host)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        return self.process()
+
+
 def ip(args, json=None, ns=None, host=None):
     cmd_str = "ip "
     if json:
@@ -47,3 +62,21 @@ import subprocess
     if json:
         return _json.loads(cmd_obj.stdout)
     return cmd_obj
+
+
+def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=1):
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


