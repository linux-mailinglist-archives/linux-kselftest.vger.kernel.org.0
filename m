Return-Path: <linux-kselftest+bounces-32266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD2AA7DDC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474AC1BC4765
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23462134AC;
	Sat,  3 May 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJA42N4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4971798F;
	Sat,  3 May 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746235140; cv=none; b=KPHvfTCPZKfPRZZAYCve5NPcJoEPGHvwqskCJWvKAQZXxf0nMjuQcRoi5S/JQx6UecTAebR0FkiZe4ZERK4A3n1t+K+A9+cCsbicP/HfQXfpyrK01SJPo29+ciwTUfp7WmTtivO4CFPkmKxgqEn2JyPQEuHJff6lNSGYJ50BgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746235140; c=relaxed/simple;
	bh=TJMIDQCtPoRrpvB6gLnZu60p+q5widiXgewefPHF1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwqy3E2AdqEcjivQ1mvex022FgvBd2uTjIigCVqUQztghqoC8E+xOh0AimlJeSXOYveH64Lqpy9qOWBSwWub9VmYWtcTRRP1ibO42wXdo20PhN+7/5QjOr5AMC+XzyhmKl6fAOrJdZoEoQ3X8VdsJF9yPpJEf/Ie6PZH5e3zEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJA42N4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3FBC4CEE4;
	Sat,  3 May 2025 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746235139;
	bh=TJMIDQCtPoRrpvB6gLnZu60p+q5widiXgewefPHF1Z4=;
	h=From:To:Cc:Subject:Date:From;
	b=eJA42N4c07HbNUBrBa86p5bCJNyBAGF9vXm6TENsflBxD4O7jo0xa4Re+DabOdLxj
	 UDtsP7tf18xu0wM8Rx83NA8Wgfkse0o68qFAjdoDPgubczU7HYczEe1Wmx4mqTcaxu
	 3duF7nyNDBlMxxk+YkS4/PhXCzLZ8rTGTUL90RI7hZwHKqd1+ravsfCUegfBZhpTZC
	 qst+plcAMbpKAcOFcjzsWtbwOQPHkIssQQMIhD1cqMif09zNcFmkWGxZuRkE1SsiH2
	 yAfp5SXCbSV2OY1suLkM1I0F2GX6bzxSBpXc2l5uIyojMZyH2SJPgVIg7oBWgwJphC
	 pCsUQYtOYUYjw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ecree.xilinx@gmail.com,
	petrm@nvidia.com,
	willemb@google.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3] selftests: net: exit cleanly on SIGTERM / timeout
Date: Fri,  2 May 2025 18:18:56 -0700
Message-ID: <20250503011856.46308-1-kuba@kernel.org>
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
v3:
 - remove unnecessary isinstance()
v2: https://lore.kernel.org/20250429170804.2649622-1-kuba@kernel.org
 - remove declaration at the global scope
v1: https://lore.kernel.org/20250425151757.1652517-1-kuba@kernel.org

CC: ecree.xilinx@gmail.com
CC: petrm@nvidia.com
CC: willemb@google.com
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3cfad0fd4570..61287c203b6e 100644
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
@@ -233,7 +253,7 @@ KSFT_DISRUPTIVE = True
             for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
             if stop:
-                ksft_pr("Stopping tests due to KeyboardInterrupt.")
+                ksft_pr(f"Stopping tests due to {type(e).__name__}.")
             KSFT_RESULT = False
             cnt_key = 'fail'
 
@@ -248,6 +268,8 @@ KSFT_DISRUPTIVE = True
         if stop:
             break
 
+    signal.signal(signal.SIGTERM, prev_sigterm)
+
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
     )
-- 
2.49.0


