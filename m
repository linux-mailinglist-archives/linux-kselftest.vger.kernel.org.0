Return-Path: <linux-kselftest+bounces-7664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD318A058A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF95B248F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB63757E6;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8HCLEYN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356873171;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798922; cv=none; b=sC38ZbWp/dcKuDT0+8JOzWu5a1i8tweIO/6LHtuSlEx4ygq3QDwv/g52kKvk/6s1SbUbptCHm0AfNEeSI8kALgJfgqRnCHcNWb0EbtU3PeU42PK8vudDvcP3M7LS2iozXboN+mEAW2wYX8055JSaKTKoEEINRIQIBzGCJOBrFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798922; c=relaxed/simple;
	bh=Nc//R23kY+H8e6cmo3oUSxdKd7WcTbsgmfEiJlWrS7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA6r1rAeHZ8gltdPRP6oPZ1asSyCk8sctAf20vorKXifPDVk3o2StGrCAZb0X6EWJI3vUflkMB4X/WElWxM50Kx8dm7216gcpLva75kXnuPXiayAnwYMOV4hLqiRti1EMqOE8mU2z3XL7PPYE2jLsnADiHywpGYQZVtGnB8kLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8HCLEYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8DC43330;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798922;
	bh=Nc//R23kY+H8e6cmo3oUSxdKd7WcTbsgmfEiJlWrS7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8HCLEYNCaS+fmwPyXQXurckLZj/gsPQryrvcqrU0vldac0IXeKwb6vOyNI/2HcMe
	 N01wnL3XYmcOD+UZ524YtNgpGp9Qopxr4f25d1Fj9pBUD1g5MbskllTyTkOwvZmES8
	 wj715FLSv5ICoKYsCGv/UqQg+0rCtx7qOnmX34mLbHCM/8i7diRUoiraiByubYgi1U
	 JVVOtUH54UvoVmbsg1/89u2XS1zhR0CfD8Vsg3+MUmQ0mfUX7Yk01/ACtCdmaSYLag
	 /VWB1I6ps2WC0hEqX8mpjiy2ioP9cZeBlPVIzMbvSstcdCu9QJnKobcRNP/G30Pxpq
	 GEwcwDI4IqgfQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/6] selftests: net: print report check location in python tests
Date: Wed, 10 Apr 2024 18:28:12 -0700
Message-ID: <20240411012815.174400-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Developing Python tests is a bit annoying because when test fails
we only print the fail message and no info about which exact check
led to it. Print the location (the first line of this example is new):

  # At /root/ksft-net-drv/./net/nl_netdev.py line 38:
  # Check failed 0 != 10
  not ok 3 nl_netdev.page_pool_check

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index c7210525981c..5838aadd95a7 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import builtins
+import inspect
 from .consts import KSFT_MAIN_NAME
 
 KSFT_RESULT = None
@@ -18,32 +19,34 @@ KSFT_RESULT = None
     print("#", *objs, **kwargs)
 
 
+def _fail(*args):
+    global KSFT_RESULT
+    KSFT_RESULT = False
+
+    frame = inspect.stack()[2]
+    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
+    ksft_pr(" ".join([str(a) for a in args]))
+
+
 def ksft_eq(a, b, comment=""):
     global KSFT_RESULT
     if a != b:
-        KSFT_RESULT = False
-        ksft_pr("Check failed", a, "!=", b, comment)
+        _fail("Check failed", a, "!=", b, comment)
 
 
 def ksft_true(a, comment=""):
-    global KSFT_RESULT
     if not a:
-        KSFT_RESULT = False
-        ksft_pr("Check failed", a, "does not eval to True", comment)
+        _fail("Check failed", a, "does not eval to True", comment)
 
 
 def ksft_in(a, b, comment=""):
-    global KSFT_RESULT
     if a not in b:
-        KSFT_RESULT = False
-        ksft_pr("Check failed", a, "not in", b, comment)
+        _fail("Check failed", a, "not in", b, comment)
 
 
 def ksft_ge(a, b, comment=""):
-    global KSFT_RESULT
     if a < b:
-        KSFT_RESULT = False
-        ksft_pr("Check failed", a, "<", b, comment)
+        _fail("Check failed", a, "<", b, comment)
 
 
 def ktap_result(ok, cnt=1, case="", comment=""):
-- 
2.44.0


