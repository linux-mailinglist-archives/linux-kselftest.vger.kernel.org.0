Return-Path: <linux-kselftest+bounces-8387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A98AA5F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCDD1C2137D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C97D091;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLkVfJDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718087CF0F;
	Thu, 18 Apr 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483533; cv=none; b=qpioEjTeyoCL3AT4hhSV0VSMk95w/5sYIKic8XyeNUyPC2/AWxDRTl9qT1usaX355+WA2O0Z3g3jBN2BxcY6tI52v021BgSt7hfS7uDTg43Y/d3GZnz2BB+YatXeior+gmKR2eFTZPeFkTyyH62u1LZoDPUghUxAD5WO/EedLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483533; c=relaxed/simple;
	bh=3EYmbp2B4r9MUqRbdnAXASyZmfi5Yfa/llFet9lNHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+wjZwnhqh5xMNG1CXqNiWj7NgqD4jwVXQLMsbEq+uTO7aFenvAg6I0ds06uVUFGnWdOE50bCvlOwHkKSU3PJ+NfwbJK9VW3BdOvNnlJ30dXFI9ZUjpK9kzZarT76TcgnO0eSYIEuMh2aNwqc34ok9aiHzLJ4TwPElKHIPZTAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLkVfJDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA96C32783;
	Thu, 18 Apr 2024 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713483533;
	bh=3EYmbp2B4r9MUqRbdnAXASyZmfi5Yfa/llFet9lNHBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLkVfJDC5Ip17lA/UwxLnd22mkj2jbp9e9HqizPlqkk57cinD0FkE9GqUPwmsKrEY
	 Zl3GUxFaL9ElyVj6udH+FbmqIwVkDasYQVkXZp/MrspGKUOu7qH220H90nWVBNgspx
	 UisS+C5ks/+OHG2YcKQjJBL8ZEpHpXgl7Cr1wq3SM0omTxxVCTLOMqRrxLdGQ1Stzt
	 pUXs8GKRqtzkaex/moM+TDI8rwWE2aHg1G5LTSFW8stJzzJEm85ARjkuD+1IeI+D79
	 O2ffFYk/UN3U7H93NfAvpCJePssRFmCq/jqzNnQgPY+33KrPm9KnmQp9Eu9Z4bnMgr
	 zCQ/4Rwv5Xsxw==
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
Subject: [PATCH net-next v4 5/7] selftests: net: support matching cases by name prefix
Date: Thu, 18 Apr 2024 16:38:42 -0700
Message-ID: <20240418233844.2762396-6-kuba@kernel.org>
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

While writing tests with a lot more cases I got tired of having
to jump back and forth to add the name of the test to the ksft_run()
list. Most unittest frameworks do some name matching, e.g. assume
that functions with names starting with test_ are test cases.

Support similar flow in ksft_run(). Let the author list the desired
prefixes. globals() need to be passed explicitly, IDK how to work
around that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4:
 - spell the code out a little to make it clearer
---
 tools/testing/selftests/drivers/net/ping.py |  3 +--
 tools/testing/selftests/net/lib/py/ksft.py  | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index e75908d7c558..9f65a0764aab 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -18,8 +18,7 @@ from lib.py import cmd
 
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([test_v4, test_v6],
-                 args=(cfg, ))
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 25f2572fa540..8018bf98a9d2 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -81,7 +81,18 @@ KSFT_RESULT_ALL = True
     print(res)
 
 
-def ksft_run(cases, args=()):
+def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+    cases = cases or []
+
+    if globs and case_pfx:
+        for key, value in globs.items():
+            if not callable(value):
+                continue
+            for prefix in case_pfx:
+                if key.startswith(prefix):
+                    cases.append(value)
+                    break
+
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     print("KTAP version 1")
-- 
2.44.0


