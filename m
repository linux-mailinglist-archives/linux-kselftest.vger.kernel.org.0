Return-Path: <linux-kselftest+bounces-8529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D28AB916
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DBC1F21693
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900814012;
	Sat, 20 Apr 2024 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YavDvFLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6841426E;
	Sat, 20 Apr 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581564; cv=none; b=rZZ2ayGq2HkmUQS2FmTa+b6J64gUdt8DTAcJwoDY8zsnLaf76dPTNsrDR+Wx/Kco+xvqEWtcYLNQid/ZsqWCPgJR+0IV8UJtnWnn94mnD9BQBj7eIZOU4GbCQr6gBzktx0NXXqIDZKzjh/LUaV5ANcp1+FsbgOkHzWZYCxZVuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581564; c=relaxed/simple;
	bh=SFq2qn8W6z/9AHmC2T4sUixcO6gC82gBDSfp9sejXE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A65oBeWryAo7UnjPJIk5QMBUdZKbEwUN01sPzOtFCuj0TYq4G3eR5DMx8WGG9c+rN7G80HAOS7iZJUFFonFEO7KVYb4KGB9mtpBhYiyTDBzHBxsLSddOR2ptQ4srYjJQFWTw+ntZurp8Y4x63mfJTIlJN+FSxd/93WpmdwrmfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YavDvFLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0F0C072AA;
	Sat, 20 Apr 2024 02:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581563;
	bh=SFq2qn8W6z/9AHmC2T4sUixcO6gC82gBDSfp9sejXE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YavDvFLG+UlQi74UOwJA43tnyhVqdOP7GErGLKNz+JHa76kfxz6aSfR5Vavwr8/72
	 0Q5k6I/r6JXOBwHvDFhRHfXXXsQ7yzSCoRyxphV296iOxL5FCE4bVls066urWID2VW
	 jwGuukcFuUM9T4ayIjmcvFVcoJMWBrsC3ggiFgmp5UO5XNQ09b+8SA1Ncxw/ysmhsU
	 PR4DLKzCngnD9/BSK9PZr0ptvQ64NN9Gzpkmnxf6zpIupZjA7sc9wAUEeBY1TpnoN3
	 XxdOAuos+9ansT7Gu5w3Ga8iFJjKJKP3gvq08Y44+Pm8vz0vRjf5v+lb0NT4STUKus
	 +wawAxr/29iig==
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
Subject: [PATCH net-next v5 6/7] selftests: drv-net: add a TCP ping test case (and useful helpers)
Date: Fri, 19 Apr 2024 19:52:36 -0700
Message-ID: <20240420025237.3309296-7-kuba@kernel.org>
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
 .../selftests/drivers/net/lib/py/env.py       |  5 +++
 tools/testing/selftests/drivers/net/ping.py   | 21 ++++++++-
 tools/testing/selftests/net/lib/py/utils.py   | 43 +++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 579c5b34e6fd..dd5cb0226a31 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -110,6 +110,11 @@ from .remote import Remote
         self.addr = self.v6 if self.v6 else self.v4
         self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
 
+        self.addr_ipver = "6" if self.v6 else "4"
+        # Bracketed addresses, some commands need IPv6 to be inside []
+        self.baddr = f"[{self.v6}]" if self.v6 else self.v4
+        self.remote_baddr = f"[{self.remote_v6}]" if self.remote_v6 else self.remote_v4
+
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 9f65a0764aab..4b49de59231c 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -2,8 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq
 from lib.py import NetDrvEpEnv
-from lib.py import cmd
+from lib.py import bkg, cmd, wait_port_listen, rand_port
 
 
 def test_v4(cfg) -> None:
@@ -16,6 +17,24 @@ from lib.py import cmd
     cmd(f"ping -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
 
 
+def test_tcp(cfg) -> None:
+    port = rand_port()
+    listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport STDOUT"
+
+    with bkg(listen_cmd, exit_wait=True) as nc:
+        wait_port_listen(port)
+
+        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
+            shell=True, host=cfg.remote)
+    ksft_eq(nc.stdout.strip(), "ping")
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as nc:
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
index 7347d0c0ff05..d3715e6c21f2 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import json as _json
+import random
+import re
 import subprocess
+import time
+
 
 class cmd:
     def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
@@ -38,6 +42,20 @@ import subprocess
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
@@ -47,3 +65,28 @@ import subprocess
     if json:
         return _json.loads(cmd_obj.stdout)
     return cmd_obj
+
+
+def rand_port():
+    """
+    Get unprivileged port, for now just random, one day we may decide to check if used.
+    """
+    return random.randint(1024, 65535)
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


