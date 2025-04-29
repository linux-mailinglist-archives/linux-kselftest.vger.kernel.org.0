Return-Path: <linux-kselftest+bounces-31909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B574AA13ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE3167792
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32224A047;
	Tue, 29 Apr 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB7opAu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C32472B0;
	Tue, 29 Apr 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946489; cv=none; b=ptd1sF+h3HARMKJTRlsqLyY1AfOLwx6++qGTWjcV0wB7nMca6zVUNdXFbjTRKNZYmvu+euGPWVnOaH0uk3VlXVh/NQ2mRVrTv8kvjTrxoqJHPMPy0wLaXR4f442c0aduDtzjIgtgipHQnKOqJ+wxUUDUfZd4PmRZGPW6D0hkZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946489; c=relaxed/simple;
	bh=IPD7ZDts+XYmEQBO2xe4njO2zX5EyzXWJdWLhHXk4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/ledqmcfTPQCwBVdhW4BBMNeVWBQcp/7tvCirduxXLOXC243xKDhx/PHPr3poUcjShq/fEU0xB8pIKOCJf89MQpmPNIhv9sjjgXVfrCFUuZ6MvKEkiIpCCz0xywzwLEnPQAu6zmJff2liKPsWGh6Q5tjtE45TW/LA6NA6aKY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB7opAu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DAEC4CEE9;
	Tue, 29 Apr 2025 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745946488;
	bh=IPD7ZDts+XYmEQBO2xe4njO2zX5EyzXWJdWLhHXk4mg=;
	h=From:To:Cc:Subject:Date:From;
	b=dB7opAu95cAjNwB/52z80HiUXpFauJX3+P0VSm34MuUE7CCsZJE/VFW1LyUtaRcR9
	 oqjLPNs5Kr4YS6BgXqUnx/Fhe1vlgMeqkLUu3/QhNV/sWtd6AI0CLfCgLnH7T1TO+D
	 fwf5LB9wzr6eWAl5e/6WUofeWXrFKYnhsEDogS/aYAD2G5xYZv4NxEMbtwPJQgiFxe
	 i+6jrvGyyGrufeleKLjZfSxnppEf5FFyUmr/98IGDmzAAHsk6b9woib2m39lqoRYzt
	 kYrDhOOcahGgb0OjDd34ih6JQ1483pwHLdoWYY5PI1RqFkgTA5RYnRgQof08c82FJX
	 pwlv9q8BruMsQ==
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
Subject: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM / timeout
Date: Tue, 29 Apr 2025 10:08:04 -0700
Message-ID: <20250429170804.2649622-1-kuba@kernel.org>
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
v2:
 - remove declaration at the global scope
v1: https://lore.kernel.org/20250425151757.1652517-1-kuba@kernel.org

CC: petrm@nvidia.com
CC: willemb@google.com
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3cfad0fd4570..1b815768bf8a 100644
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
 
@@ -193,6 +198,17 @@ KSFT_DISRUPTIVE = True
     return env
 
 
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
 
@@ -205,6 +221,10 @@ KSFT_DISRUPTIVE = True
                     cases.append(value)
                     break
 
+    global term_cnt
+    term_cnt = 0
+    prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
+
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("TAP version 13")
@@ -229,11 +249,12 @@ KSFT_DISRUPTIVE = True
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
 
@@ -248,6 +269,8 @@ KSFT_DISRUPTIVE = True
         if stop:
             break
 
+    signal.signal(signal.SIGTERM, prev_sigterm)
+
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
     )
-- 
2.49.0


