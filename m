Return-Path: <linux-kselftest+bounces-45924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39710C6BC73
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ED334EAA6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CF3115B0;
	Tue, 18 Nov 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa2P+wk4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830152FABEE;
	Tue, 18 Nov 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502724; cv=none; b=I4XiImWS4n9y0J0Lue7Gvs3bJnc28NJbQPJ2H+3AY2zT/1GRcXfPUeSlw1pGEmg+lmObQMeGvxdRCedkxKljV7PhIGbbdNzjfzmT5muN1p1CIGBCmZFSPJJwkUH7agpCpX0K08ntyXp93Zsg0uQyvgWq1qV8iZoFPciTO0f7pW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502724; c=relaxed/simple;
	bh=BfrK9At+seXbaXKu206vTShieD9bAV17RgflbI8kc34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV1n6erxF35ptxd5hpkQn6RCwu1nPIJ2Q6/X9xXIIg9ldfxo90pQdra2YvdkTBOGHaGAdxAS2MgSMKn0nNGxJFkFrM9jbP2OGvxiqIOq4hROcekuSLgnSssLpSS5ATZDZCPQEEN0rn7Eoqd7ABcD+MYI1HibkjSPdr6m7M5s6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa2P+wk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BD5C4AF15;
	Tue, 18 Nov 2025 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502724;
	bh=BfrK9At+seXbaXKu206vTShieD9bAV17RgflbI8kc34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sa2P+wk4jZFnS5xBplnOo546W17iEfSG/or7WzHmRZmcaNTMhBLnMxYVZK03R1D0I
	 4ZH94o5wruq+8VEQPS4B9wd7hogxnmWNXrToMhVgIYnnsFutwxDczVxiCStgDs7lTU
	 BDey38wvhkb87rN1CwTQX0q6CfPjIQKlTZTPStkPG+Aj0wSHxgQK7P2rfrDQIhn/6o
	 Khinsc6nxZMEOe2wKbR3XeYISsMM9fDvxo7ZncN7gaIU6Ib0w6TVrJgFMH+dAuxPF1
	 sZqQEpGaps+hdZUJPhyTttl8SJ96M8WyjvuAVlrGdawN9gz/auLVDfMGj2saqiXwF1
	 zc8LsBiEpjwTw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/12] selftests: net: py: support ksft ready without wait
Date: Tue, 18 Nov 2025 13:51:20 -0800
Message-ID: <20251118215126.2225826-7-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a common synchronization problem when a script (Python test)
uses a C program to set up some state (usually start a receiving
process for traffic). The script needs to know when the process
has fully initialized. The inverse of the problem exists for shutting
the process down - we need a reliable way to tell the process to exit.

We added helpers to do this safely in
commit 71477137994f ("selftests: drv-net: add a way to wait for a local process")
unfortunately the two operations (wait for init, and shutdown) are
controlled by a single parameter (ksft_wait). Add support for using
ksft_ready without using the second fd for exit.

This is useful for programs which wait for a specific number of packets
to rx so exit_wait is a good match, but we still need to wait for init.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index cb40ecef9456..106ee1f2df86 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -32,7 +32,7 @@ import time
     Use bkg() instead to run a command in the background.
     """
     def __init__(self, comm, shell=None, fail=True, ns=None, background=False,
-                 host=None, timeout=5, ksft_wait=None):
+                 host=None, timeout=5, ksft_ready=None, ksft_wait=None):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
@@ -52,21 +52,25 @@ import time
             # ksft_wait lets us wait for the background process to fully start,
             # we pass an FD to the child process, and wait for it to write back.
             # Similarly term_fd tells child it's time to exit.
-            pass_fds = ()
+            pass_fds = []
             env = os.environ.copy()
             if ksft_wait is not None:
-                rfd, ready_fd = os.pipe()
                 wait_fd, self.ksft_term_fd = os.pipe()
-                pass_fds = (ready_fd, wait_fd, )
-                env["KSFT_READY_FD"] = str(ready_fd)
+                pass_fds.append(wait_fd)
                 env["KSFT_WAIT_FD"]  = str(wait_fd)
+                ksft_ready = True  # ksft_wait implies ready
+            if ksft_ready is not None:
+                rfd, ready_fd = os.pipe()
+                pass_fds.append(ready_fd)
+                env["KSFT_READY_FD"] = str(ready_fd)
 
             self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
                                          stderr=subprocess.PIPE, pass_fds=pass_fds,
                                          env=env)
             if ksft_wait is not None:
-                os.close(ready_fd)
                 os.close(wait_fd)
+            if ksft_ready is not None:
+                os.close(ready_fd)
                 msg = fd_read_timeout(rfd, ksft_wait)
                 os.close(rfd)
                 if not msg:
@@ -116,10 +120,10 @@ import time
         with bkg("my_binary", ksft_wait=5):
     """
     def __init__(self, comm, shell=None, fail=None, ns=None, host=None,
-                 exit_wait=False, ksft_wait=None):
+                 exit_wait=False, ksft_ready=None, ksft_wait=None):
         super().__init__(comm, background=True,
                          shell=shell, fail=fail, ns=ns, host=host,
-                         ksft_wait=ksft_wait)
+                         ksft_ready=ksft_ready, ksft_wait=ksft_wait)
         self.terminate = not exit_wait and not ksft_wait
         self._exit_wait = exit_wait
         self.check_fail = fail
-- 
2.51.1


