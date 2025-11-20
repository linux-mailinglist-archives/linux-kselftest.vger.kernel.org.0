Return-Path: <linux-kselftest+bounces-46039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D831FC71C5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3520F351317
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0827A900;
	Thu, 20 Nov 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVmRDk8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5682798F8;
	Thu, 20 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604642; cv=none; b=Yd102EKMdcWMWc8zXc3fhKHJ5x3RqHkGNkAaLSQozgVlG1gL1YsEkcLx/ZH1p+9Ky9tk2cr4HIQleLqaSSWbsuyeOhMsRGz9Cm2c7DecMPObzS9JzQoY3ntZnepZw2fWL8xJCkNOVibe9657B+AF9YBj8Sg6UWaua7J/pKW1ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604642; c=relaxed/simple;
	bh=Qo4QEFFmQO4L9iux80LxFoTJodojfphNL6CQghtFX3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsW9wcL5h995nHWxYzyRVHf3xCRArtqfOfp1DpoR7t+axhJFA4IzaTLp1VRevzbx/HKJgRzDh25IVpIjsQmZA5TzDMftnTR2xxdo1IqWgEJZCMyUP7wjbcveDiFHpWoZvmyrtNwhcqokWsYcIiDxv4WmgxaVm2GlfnUP1UDy13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVmRDk8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3465C16AAE;
	Thu, 20 Nov 2025 02:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604642;
	bh=Qo4QEFFmQO4L9iux80LxFoTJodojfphNL6CQghtFX3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVmRDk8OgEJKER8wC1Ya8B8c3Z/jij3NT1JuiSpT98tQ4r4204TwUWqWJD39tjTh9
	 J6qPooVLQnw17xxIoi4wR840YtnQzXCiZkmHtr5cBBK/JinPe4GeEFQ7yAAtZyi/H0
	 +0s1rA0xy8qG56/ULs+WPSzlVGPaYpVzAjS1xVAAQMReKVwiRlsNjv6IfGkso2mT+B
	 MiemK/rQ5x9pSVeg6Wl2i29jkiADgiE0m7jaqrXVc8izteQoCL/k9ySVMGgIZo15FB
	 F/juBE4khWmS0E2MLC46EWSqYUHA+DymwD8NBL0H217iFsm30rVRcJPIWkq/g9ZULs
	 9KbdfPx0XlM5Q==
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
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 02/12] selftests: net: py: extract the case generation logic
Date: Wed, 19 Nov 2025 18:10:14 -0800
Message-ID: <20251120021024.2944527-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
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

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 2eed24244b8a..3ef39436302a 100644
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


