Return-Path: <linux-kselftest+bounces-48800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BBD15EFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB47F3043F0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7615C158;
	Tue, 13 Jan 2026 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5NKtTXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB43B1BD;
	Tue, 13 Jan 2026 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262867; cv=none; b=P50p+88WPKvPjv4wyhQbIF4g9u8dh41MEeX9Y6hF+RVwmOHKcvGQx9StmImcqpLSYGWR3Zgunzic+SXoWALsoi4sjZqqYQ6V/HymeSfUfrewtwIaXTj3cT+sjuCD/EMuoUKFj/Ty5Ic0PBLdS7N1p6Vg+whtbDYSg05rjPiqPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262867; c=relaxed/simple;
	bh=Bg0DSDtbxrsikheB1ysqAuXP4vBBKGEfSHi4y4G54Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMMp5EwzRKa41wcBzkWn0VhJTNxDgPvpkZL45erLPRZ3CTUhbx1jTKr4qQEbi+lgG7Jj0lFDhL1E4ua8SUSAWceMBgN1sRx+IsCI2P64DCh8Dh02G5RGyoXZugKCCSTj8EgadG5bDo2/KeluCDF8jBGIRgosKwf5ujC56NQ9kNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5NKtTXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3698C2BC86;
	Tue, 13 Jan 2026 00:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262867;
	bh=Bg0DSDtbxrsikheB1ysqAuXP4vBBKGEfSHi4y4G54Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5NKtTXSmOZ/sJ2B4FxLYKCVsLMjmhXqusvvoh8b+G19JUDEuDW6SrM+0Yc+MRsNP
	 QELXZ0W/5Dps4wrCTJRBCxcyZBtN+qZKSrWX4MAA6ufkNFIPs26mOb5VSVsLlB0ti1
	 Zipi8iajgkP+gfDmZ6Ig5qto+lK/2CLhTNvJzYPkPulAWqBgKKG7YhWLV3BSKJD0lB
	 gxZ9S+/tDY9oTyfcji+YZo2QZPxVgK+Z/y/rWVkzTfO3tcKRxVNrixiXlhhYLLAYxE
	 VYI4AzV2q0ueyGQ6Gb3Tf6SXSJ4lr3EXF9dUKxaW3sq8Se2esCOOlJWEhJ2Xifrxqt
	 UYCaGkO2uKVAA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/6] selftests: net: py: teach ksft_pr() multi-line safety
Date: Mon, 12 Jan 2026 16:07:35 -0800
Message-ID: <20260113000740.255360-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
References: <20260113000740.255360-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make printing multi-line logs easier by automatically prefixing
each line in ksft_pr(). Make use of this when formatting exceptions.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 0a96f88bb60a..6cdfb8afccb5 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -32,8 +32,23 @@ KSFT_DISRUPTIVE = True
 
 
 def ksft_pr(*objs, **kwargs):
+    """
+    Print logs to stdout.
+
+    Behaves like print() but log lines will be prefixed
+    with # to prevent breaking the TAP output formatting.
+
+    Extra arguments (on top of what print() supports):
+      line_pfx - add extra string before each line
+    """
+    sep = kwargs.pop("sep", " ")
+    pfx = kwargs.pop("line_pfx", "")
+    pfx = "#" + (" " + pfx if pfx else "")
     kwargs["flush"] = True
-    print("#", *objs, **kwargs)
+
+    text = sep.join(str(obj) for obj in objs)
+    prefixed = f"\n{pfx} ".join(text.split('\n'))
+    print(pfx, prefixed, **kwargs)
 
 
 def _fail(*args):
@@ -170,9 +185,7 @@ KSFT_DISRUPTIVE = True
             entry.exec_only()
         except Exception:
             ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
-            tb = traceback.format_exc()
-            for line in tb.strip().split('\n'):
-                ksft_pr("Defer Exception|", line)
+            ksft_pr(traceback.format_exc(), line_pfx="Defer Exception|")
             KSFT_RESULT = False
 
 
@@ -331,9 +344,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
             cnt_key = 'xfail'
         except BaseException as e:
             stop |= isinstance(e, KeyboardInterrupt)
-            tb = traceback.format_exc()
-            for line in tb.strip().split('\n'):
-                ksft_pr("Exception|", line)
+            ksft_pr(traceback.format_exc(), line_pfx="Exception|")
             if stop:
                 ksft_pr(f"Stopping tests due to {type(e).__name__}.")
             KSFT_RESULT = False
@@ -343,9 +354,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         try:
             ksft_flush_defer()
         except BaseException as e:
-            tb = traceback.format_exc()
-            for line in tb.strip().split('\n'):
-                ksft_pr("Exception|", line)
+            ksft_pr(traceback.format_exc(), line_pfx="Exception|")
             if isinstance(e, KeyboardInterrupt):
                 ksft_pr()
                 ksft_pr("WARN: defer() interrupted, cleanup may be incomplete.")
-- 
2.52.0


