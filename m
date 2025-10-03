Return-Path: <linux-kselftest+bounces-42747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2BBB86A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B0618988B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69CD2C2364;
	Fri,  3 Oct 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7/SROxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B92C21CF;
	Fri,  3 Oct 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534261; cv=none; b=fTNX4EoW0+gFzWxnx88T46sR09ff1e8FYrVEbGKOcHmw+co82XSmH7eHoSqjb7vz1tW10iH6L4dtY3sVISVEIlEw2GY+hDVWjuDVgz9Tu2/tNT4rfWi9OxnM1fwRjtrPHyM7E3E0cgs6odpuiCmJRcZOdz/smL3hVw+0bN7Pbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534261; c=relaxed/simple;
	bh=OOOWbFfjvKsuYankKxFL3OTuPBM7d5eXqKzIV87L0Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoArdGAipPzqtJDiWuttkY0su0upFGH9h8uuPDKxpz6nmyks27HO4IO0n1sDixpA8/SgtBAH4j4LxcZ0Qb0BVOIoOtvsZwl5qn5ulhHlQKeyX1EfQLvdRLK+BNDs6NbC5Wrl1xpjQfrSiuvIgp95rWQGVB3G2H8oH9cXbqGlcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7/SROxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB2CC4CEFD;
	Fri,  3 Oct 2025 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534261;
	bh=OOOWbFfjvKsuYankKxFL3OTuPBM7d5eXqKzIV87L0Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7/SROxCar4MQ/2Kurg1ShLUUTwEy1WhtqbUckj/2LxupfZYI3R5KAF2HZKsNCHVs
	 +slWzjpiaC9kXPQpr7SxqA46mlrfSxqlww9YQz4dyWcnos+8+FdkxLlpwKMEeIMxiS
	 CzwC0ExLLllCWGWO5inYqKUhCHN/XfPvotk9LVST/rlEl18BqjhE5gRuKXgXlGk0wk
	 w/L4VmsQxm+wqG0/mDJPPTOdQC+Glu4gjyIle5Q+YsalvCLZyySAcWgez3j8Jn+C6X
	 wlTbl3E2QHBrqpjQSFjfEKigO3dUJmcjO/bDYYUsLKx8t0fkubGIvfwNeM2oiqQtiq
	 Uppnc9F9nunLQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	johndale@cisco.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 8/9] selftests: drv-net: pp_alloc_fail: lower traffic expectations
Date: Fri,  3 Oct 2025 16:30:24 -0700
Message-ID: <20251003233025.1157158-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lower the expected level of traffic in the pp_alloc_fail test
and calculate failure counter thresholds based on the traffic
rather than using a fixed constant.

We only have "QEMU HW" in NIPA right now, and the test (due to
debug dependencies) only works on debug kernels in the first place.
We need some place for it to pass otherwise it seems to be bit
rotting. So lower the traffic threshold so that it passes on QEMU
and with a debug kernel...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: johndale@cisco.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/pp_alloc_fail.py      | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index fc66b7a7b149..a4521a912d61 100755
--- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -7,6 +7,7 @@ Test driver resilience vs page pool allocation failures.
 
 import errno
 import time
+import math
 import os
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import KsftSkipEx, KsftFailEx
@@ -62,7 +63,7 @@ from lib.py import cmd, tool, GenerateTraffic
         stat1 = get_stats()
         time.sleep(1)
         stat2 = get_stats()
-        if stat2['rx-packets'] - stat1['rx-packets'] < 15000:
+        if stat2['rx-packets'] - stat1['rx-packets'] < 4000:
             raise KsftFailEx("Traffic seems low:", stat2['rx-packets'] - stat1['rx-packets'])
 
 
@@ -91,9 +92,14 @@ from lib.py import cmd, tool, GenerateTraffic
 
         if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 1:
             raise KsftSkipEx("Allocation failures not increasing")
-        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 100:
-            raise KsftSkipEx("Allocation increasing too slowly", s2['rx-alloc-fail'] - s1['rx-alloc-fail'],
-                             "packets:", s2['rx-packets'] - s1['rx-packets'])
+        pkts = s2['rx-packets'] - s1['rx-packets']
+        # Expecting one failure per 512 buffers, 3.1x safety margin
+        want_fails = math.floor(pkts / 512 / 3.1)
+        seen_fails = s2['rx-alloc-fail'] - s1['rx-alloc-fail']
+        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < want_fails:
+            raise KsftSkipEx("Allocation increasing too slowly", seen_fails,
+                             "packets:", pkts)
+        ksft_pr(f"Seen: pkts:{pkts} fails:{seen_fails} (pass thrs:{want_fails})")
 
         # Basic failures are fine, try to wobble some settings to catch extra failures
         check_traffic_flowing()
-- 
2.51.0


