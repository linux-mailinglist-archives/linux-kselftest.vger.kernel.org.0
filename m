Return-Path: <linux-kselftest+bounces-46681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F1C90747
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CD364E033E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757F217F33;
	Fri, 28 Nov 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUIoasXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321D20B22;
	Fri, 28 Nov 2025 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290931; cv=none; b=IDaAgwpzynh71yZ7y0V42NUEcw5Ag//pi4pu6JWszphTLmpKbehuoZuFrSOGumTaa4BNvosWnSX6wgPt0BwHxZGcArLB/qQHdKSEOxQDGWZIIaQcuHBh5+XH0ztCxXEeSYLLoXfNPgeih4i3KVz7aYm0auXwGVWK19M7E7ggY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290931; c=relaxed/simple;
	bh=Td66z1VEFMXwMvZf7Zzix0wOIQxl7V8ZtvG0w0bo+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POgGBswyS2+II6/50jAVbW3r/tADHq1D32249tiGquhtahQkPIyu9nUopbJBe3Bmql/ZpMUWoKifZikznpPM7iMqLib++Ylf9hzChJ6geTrQgzsHMW+VdiqQSnA2S0wLcTcjfj74azYt5nfHsILhjO1D3Tzb+CbiJb9GWzkk+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUIoasXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29CDC4CEF8;
	Fri, 28 Nov 2025 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764290929;
	bh=Td66z1VEFMXwMvZf7Zzix0wOIQxl7V8ZtvG0w0bo+E8=;
	h=From:To:Cc:Subject:Date:From;
	b=AUIoasXopAs2vdmrFS0AiMn5on46jJlC0Xr/Bv2GqvpBILcbwJomOXZbW2WySoF8A
	 MBEU1NXXE7Zjtya2p3qKISBZkQ0wy2GZKVdns9WUCfi2spT+aBTLRJUxEBAfzfhswU
	 +PoYTeW/JAwA1nLyW6aPtR8O3O7htNWu3O/cDrPGtSRt42VOPdKYt2xhMjFQwM366z
	 RNzhkifqH0sI779sZbBH5rip2E2iTg0iBtyD8ZRzk8guAT8r0A7ZUbMrIWiMiNH+Bj
	 j9NuX9IO/eYXiehHN1kHcVF8NusOshfXGZlyiDfvqzZ+2fo8LLGWJTVDUAGgPtGbfi
	 vhYRPJa7oUDwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: py: handle interrupt during cleanup
Date: Thu, 27 Nov 2025 16:48:46 -0800
Message-ID: <20251128004846.2602687-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on the old discussion [1]. Let the BaseExceptions out of
defer()'ed cleanup. And handle it in the main loop. This allows us to
exit the tests if user hit Ctrl-C during defer().

Link: https://lore.kernel.org/20251119063228.3adfd743@kernel.org # [1]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index ebd82940ee50..531e7fa1b3ea 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -163,7 +163,7 @@ KSFT_DISRUPTIVE = True
         entry = global_defer_queue.pop()
         try:
             entry.exec_only()
-        except BaseException:
+        except Exception:
             ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
@@ -333,7 +333,21 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
             KSFT_RESULT = False
             cnt_key = 'fail'
 
-        ksft_flush_defer()
+        try:
+            ksft_flush_defer()
+        except BaseException as e:
+            tb = traceback.format_exc()
+            for line in tb.strip().split('\n'):
+                ksft_pr("Exception|", line)
+            if isinstance(e, KeyboardInterrupt):
+                ksft_pr()
+                ksft_pr("WARN: defer() interrupted, cleanup may be incomplete.")
+                ksft_pr("      Attempting to finish cleanup before exiting.")
+                ksft_pr("      Interrupt again to exit immediately.")
+                ksft_pr()
+                stop = True
+            # Flush was interrupted, try to finish the job best we can
+            ksft_flush_defer()
 
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
-- 
2.51.1


