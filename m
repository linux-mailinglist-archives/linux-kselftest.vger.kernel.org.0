Return-Path: <linux-kselftest+bounces-7804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7A8A303E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186C3285D07
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3F1272AB;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIXSmsCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6008615F;
	Fri, 12 Apr 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931283; cv=none; b=jXgAmN9fcFFIsSc+x4+Hl/sGSkUIRhvZ4HsT2nSBdrWNyFdyVjcMA3D5zKFr3r9r25K9MI4nDyZ0/zM1eZSczr22wlUUCgGxX3VLhi8mv5ooVYSzn3p6B2ZHSiVwi3FH/9rbfX4JOXtjgnlOxWYXFy8ro1Gmm+v8nBfvugZWE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931283; c=relaxed/simple;
	bh=hPhQCHvhkEATSLUEgZyXF+5+mjJeaxY6UqwRPzblV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixN1hmf7pk90f03oPdE3N3tsCpo3vbdiwMtIBy2LFIq2y5TnQwDKsHXqbzysmvVuThG1r7WvPk62w1tR7sZ3DEKpoP0jCbP8WeVmLWfu8A2m8JT7dkD9SlcNx1HsVbWA+WVp2FqgCV/TWAIF6M5wc+3jiLfBRgcp6OTQMyllymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIXSmsCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F47C4AF10;
	Fri, 12 Apr 2024 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931282;
	bh=hPhQCHvhkEATSLUEgZyXF+5+mjJeaxY6UqwRPzblV1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIXSmsCXpYSDwHjT/a9x1rXSj2rmyi1E3xtY1lKWKgx1C6iY8cT7pi0lQSHeH8oh2
	 fAeS5Qs6CYtDHMowiaQ9OjAc4bzW+xegmrzNcTm27hrLw5c3QgSojpSlk11tunbgTf
	 BDLu1HhXQHBi8jO6eWF0gwsEwX6Yku7MU7QoOGtrpK6RqXE4ykvJ3/tWNq65sU+3sT
	 3AzWNpQKOgITOLY5yzXS8WO6T7a1RcG/b3yQO2xDi1ITYb1Pfx1DFw1hccvRmtjZCW
	 RcC6FrLfzd1kMwv9n6ekykhpLt5Cbx74lz03lOxqitFg/BPIMV4h7hzEvume2Re1Hx
	 8Mpv62S/nzi6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/6] selftests: net: print report check location in python tests
Date: Fri, 12 Apr 2024 07:14:33 -0700
Message-ID: <20240412141436.828666-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
References: <20240412141436.828666-1-kuba@kernel.org>
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

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: - pass *args from fail to pr
---
 tools/testing/selftests/net/lib/py/ksft.py | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index c7210525981c..b4b0bfff68b0 100644
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
+    ksft_pr(*args)
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


