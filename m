Return-Path: <linux-kselftest+bounces-45783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9EC662C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E680C35B15C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F534C801;
	Mon, 17 Nov 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO1CtctT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926434C13B;
	Mon, 17 Nov 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413110; cv=none; b=e6R469I9Jq8qHlOZRwLcpJfXwQusFMoJ/j4koaFJhh79q+s+PE1Usb5zlAwlHTPPyjIfmVas6vJzpMmpo2hOm6IQSatgSkKoHhEEbqUcJiINnrjoy0scsSFg/qD5kQEv7VWwf4BMCewKIxOV8YTPdHWDB++eJF2sA60F9ILACU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413110; c=relaxed/simple;
	bh=3uKU+gcjE98LmB0fQ2hCAOBWsrEvwuLH9xh1mn2xG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slAyOOLQuQr5iHlSJttX6b6ViUI/OM4pfGU3jjoR/oLvLHM+vd/TZT95VxEfXiyuDytz+3Dcd6de6bBh1SULReMxI//M8NpYQux2ZTfyY1HLsbi6zBHHAnfWjpvJfOI0grLjHgfuUdp1OuL+KTRRHcZBAp/QN63Ha3uZiaJTVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO1CtctT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5710DC19421;
	Mon, 17 Nov 2025 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413109;
	bh=3uKU+gcjE98LmB0fQ2hCAOBWsrEvwuLH9xh1mn2xG18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HO1CtctTsEUVPzKoowRlQeYFQyIEdVkVzzCptDOxj7gWccmM1QML2iPstlAC9fiS2
	 jRWMYGKitZU+LtcxA9pq3yh/fPKITfzJc4H1Bm7Tayk48HeroSOvmcDQl5l6csrcp1
	 uBQrYXbaZ759K8stXsI4stZtiPNZglyfHa5683mzbVSyPbtxgkXZrr0nuW9YfF3fV0
	 R5XoFQ84b/x66qqiwbOcprKIJE1akg+gXKjb2G0VfT6PGJ7HYCm477FHuYWevCPueg
	 vpkMQhBWv/fzMNcnh0NEvfMqoGfBcAafhYzoCat4QtdrdaWv5M/cyvsL/pnlZHpdgQ
	 NYL6zVhTpJC7w==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/12] selftests: net: py: extract the case generation logic
Date: Mon, 17 Nov 2025 12:58:00 -0800
Message-ID: <20251117205810.1617533-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
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


