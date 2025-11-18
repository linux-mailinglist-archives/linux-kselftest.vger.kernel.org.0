Return-Path: <linux-kselftest+bounces-45920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0DC6BC43
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 10DD22BB0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECA30EF92;
	Tue, 18 Nov 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4PNtptL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D33702EE;
	Tue, 18 Nov 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502718; cv=none; b=LHBD4KUvExcXAayrG61Bdne2Ned0gv5XRv7X+XAVc1Mb4baZP12erY8IFs4ZFdb//ch6ZUheYy8QcWB1CENipF5IcHPpig+KeU/A6BR6PV501iVdrUplJCVqjLde1h649+BXxKPYDhf9qGZ/W1ORO5MWjTidE9dcC9ATcp2Maho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502718; c=relaxed/simple;
	bh=3uKU+gcjE98LmB0fQ2hCAOBWsrEvwuLH9xh1mn2xG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyOpKAOyZzmSTMsmO6EHJfsliYEBYr8sHWlL42XgNuJ7Pa1ew6YRnK5ytjdpLjVaqWkJ69h/1pxxvqBCAOqmAyVaLPTogazhCPyP3OM3UekCJmRVuIRyvoefIGyUZN3q65ah1fBJtzEI9Cb4n7AmsNC85oAshcPEmj8s1bE52+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4PNtptL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E5C2BCB1;
	Tue, 18 Nov 2025 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502718;
	bh=3uKU+gcjE98LmB0fQ2hCAOBWsrEvwuLH9xh1mn2xG18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4PNtptLffdVSGRqQHQNVRlSMeapoNjSIXcHA9hNYWt4U5uAc2JjOv5iWzVDxu6g+
	 YcuUBoYbBtXMDr8R+R3TItNoljMA8JaRYiFMQKAESghKmF/qEh/THB46JiBwqP2P/7
	 r36jyn8GqVYCERcPZnbvMkpgxhqU1h+9wsZyaW1Pyv+QNgZJczIF6RLHBkACqQcToO
	 TihRZXjfVltC8Zpt1WZC5yoTwBeeJvX709WKvuzBcqTtDW4VZNl2n5xyCaaNWD00N5
	 BVIe/v3YxBCCAV7I1uOtMFyBMW6jXVOoJtZvtvWTgOTydTFvWrnCO9do8W3InDn+MU
	 VXR8jQNO2cpuQ==
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
Subject: [PATCH net-next v2 02/12] selftests: net: py: extract the case generation logic
Date: Tue, 18 Nov 2025 13:51:16 -0800
Message-ID: <20251118215126.2225826-3-kuba@kernel.org>
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

In preparation for adding test variants move the test case
collection logic to a dedicated function. New helper returns

 (function, args, name, )

tuples. The main test loop can simply run them, not much
logic or discernment needed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 56dd9bd060cd..52c42c313cf2 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -135,7 +135,7 @@ KSFT_DISRUPTIVE = True
         time.sleep(sleep)
 
 
-def ktap_result(ok, cnt=1, case="", comment=""):
+def ktap_result(ok, cnt=1, case_name="", comment=""):
     global KSFT_RESULT_ALL
     KSFT_RESULT_ALL = KSFT_RESULT_ALL and ok
 
@@ -145,8 +145,8 @@ KSFT_DISRUPTIVE = True
     res += "ok "
     res += str(cnt) + " "
     res += KSFT_MAIN_NAME
-    if case:
-        res += "." + str(case.__name__)
+    if case_name:
+        res += "." + case_name
     if comment:
         res += " # " + comment
     print(res, flush=True)
@@ -219,9 +219,13 @@ KSFT_DISRUPTIVE = True
         ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
 
 
-def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
-    cases = cases or []
+def _ksft_generate_test_cases(cases, globs, case_pfx, args):
+    """Generate a flat list of (func, args, name) tuples"""
 
+    cases = cases or []
+    test_cases = []
+
+    # If using the globs method find all relevant functions
     if globs and case_pfx:
         for key, value in globs.items():
             if not callable(value):
@@ -231,6 +235,15 @@ KSFT_DISRUPTIVE = True
                     cases.append(value)
                     break
 
+    for func in cases:
+        test_cases.append((func, args, func.__name__))
+
+    return test_cases
+
+
+def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+    test_cases = _ksft_generate_test_cases(cases, globs, case_pfx, args)
+
     global term_cnt
     term_cnt = 0
     prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
@@ -238,19 +251,19 @@ KSFT_DISRUPTIVE = True
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("TAP version 13", flush=True)
-    print("1.." + str(len(cases)), flush=True)
+    print("1.." + str(len(test_cases)), flush=True)
 
     global KSFT_RESULT
     cnt = 0
     stop = False
-    for case in cases:
+    for func, args, name in test_cases:
         KSFT_RESULT = True
         cnt += 1
         comment = ""
         cnt_key = ""
 
         try:
-            case(*args)
+            func(*args)
         except KsftSkipEx as e:
             comment = "SKIP " + str(e)
             cnt_key = 'skip'
@@ -272,7 +285,7 @@ KSFT_DISRUPTIVE = True
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
-        ktap_result(KSFT_RESULT, cnt, case, comment=comment)
+        ktap_result(KSFT_RESULT, cnt, name, comment=comment)
         totals[cnt_key] += 1
 
         if stop:
-- 
2.51.1


