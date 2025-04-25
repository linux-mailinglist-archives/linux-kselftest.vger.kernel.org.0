Return-Path: <linux-kselftest+bounces-31651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD01A9CCA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340FA1BC1FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567427A90F;
	Fri, 25 Apr 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7kB9lL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7C258CE5;
	Fri, 25 Apr 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594279; cv=none; b=LEa8lSu5Nm5BIzNgxajgRai67GYE3WX0B/YltaAD1ufs/2h5kTMlW/hz0fp/JJBL8k8Y86Eo4rpCbPBzVT5bFqxaEMph1kS+7X5EJRYZMMAckhD2dhwM//j0lrJwiQxE6SL7nt/oqxjbLvX8kW7z8JK+iqcFGxJnVjm7a7Sgbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594279; c=relaxed/simple;
	bh=4UD0bUp7w5tb6Y3Q1n7KVvoM+LH2jLYbHQ/VWEmnT9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTgaLlSKFgce+8g2Sj+41+1XMADfAx3YIIN3p+ABcLQpz8MXWRRzXudZPfhdpXeK/kZvS3FHUxG0cEQ5daOGCPNWCLEgyvbE5OypF35snj8nJ49kBTu1Yx7B9EeNSJRHMy9DfnovttdSmzJ21keST4IjwkGBtkYhwWBSE6VeOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7kB9lL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A76C4CEE4;
	Fri, 25 Apr 2025 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745594279;
	bh=4UD0bUp7w5tb6Y3Q1n7KVvoM+LH2jLYbHQ/VWEmnT9I=;
	h=From:To:Cc:Subject:Date:From;
	b=R7kB9lL1LmCuOaWI9Z9MRkxtYJM74qbDHClkZ7tE//9IJTBS/XhozDTG1RHm+YqNE
	 QPeBPBLLTxTrw6jPfYVRTdVFyK6ennnJAnwxPqS7ZhNwYA8lQKSUKGOKTki6Gxw9DD
	 1pi6pCofBfPZdKJVk6oFwB5Pm1/6umg3yUOFS3CI6bubPvG2fBW+ljfaRiac0hN+50
	 2HicqXFo/elhvCU4iSzUydMFB54ExKShxknKg2uY3iX6WETx6Y3j4w9Mum9hvBYw5P
	 TmCTkid9aPjsGcjOioiYyVAr9zXI6zAwk+4t7w0Yg88QPpRc46R19i+nNasY1SPaHE
	 vGRR6pIva5keA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	petrm@nvidia.com,
	willemb@google.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: exit cleanly on SIGTERM / timeout
Date: Fri, 25 Apr 2025 08:17:57 -0700
Message-ID: <20250425151757.1652517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksft runner sends 2 SIGTERMs in a row if a test runs out of time.
Handle this in a similar way we handle SIGINT - cleanup and stop
running further tests.

Because we get 2 signals we need a bit of logic to ignore
the subsequent one, they come immediately one after the other
(due to commit 9616cb34b08e ("kselftest/runner.sh: Propagate SIGTERM
to runner child")).

This change makes sure we run cleanup (scheduled defer()s)
and also print a stack trace on SIGTERM, which doesn't happen
by default. Tests occasionally hang in NIPA and it's impossible
to tell what they are waiting from or doing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: petrm@nvidia.com
CC: willemb@google.com
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3cfad0fd4570..73710634d457 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -3,6 +3,7 @@
 import builtins
 import functools
 import inspect
+import signal
 import sys
 import time
 import traceback
@@ -26,6 +27,10 @@ KSFT_DISRUPTIVE = True
     pass
 
 
+class KsftTerminate(KeyboardInterrupt):
+    pass
+
+
 def ksft_pr(*objs, **kwargs):
     print("#", *objs, **kwargs)
 
@@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
     return env
 
 
+term_cnt = 0
+
+def _ksft_intr(signum, frame):
+    # ksft runner.sh sends 2 SIGTERMs in a row on a timeout
+    # if we don't ignore the second one it will stop us from handling cleanup
+    global term_cnt
+    term_cnt += 1
+    if term_cnt == 1:
+        raise KsftTerminate()
+    else:
+        ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
+
+
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
     cases = cases or []
 
@@ -205,6 +223,10 @@ KSFT_DISRUPTIVE = True
                     cases.append(value)
                     break
 
+    global term_cnt
+    term_cnt = 0
+    prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
+
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("TAP version 13")
@@ -229,11 +251,12 @@ KSFT_DISRUPTIVE = True
             cnt_key = 'xfail'
         except BaseException as e:
             stop |= isinstance(e, KeyboardInterrupt)
+            stop |= isinstance(e, KsftTerminate)
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
             if stop:
-                ksft_pr("Stopping tests due to KeyboardInterrupt.")
+                ksft_pr(f"Stopping tests due to {type(e).__name__}.")
             KSFT_RESULT = False
             cnt_key = 'fail'
 
@@ -248,6 +271,8 @@ KSFT_DISRUPTIVE = True
         if stop:
             break
 
+    signal.signal(signal.SIGTERM, prev_sigterm)
+
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
     )
-- 
2.49.0


