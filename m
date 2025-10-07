Return-Path: <linux-kselftest+bounces-42859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320BBC2F30
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 01:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4568F19A2B8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2179F26E146;
	Tue,  7 Oct 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUdwSb6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21525A2CF;
	Tue,  7 Oct 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879633; cv=none; b=sQSQI4KFXzXiJZ4TiVW2E1uwDcxMqWJCzkgk3Ysy+KdpJztTuWO9XJiy5xaq+Qve3irqkVMMUhUm+v47+SZeeMdKdYvFYawhHAU9C9gguNV4d7/N0AiWyPg7X0Xx3hYi8vKx81iDBMbQ3tVihoIxVYxIqbeD5RN30LlqYMw3OFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879633; c=relaxed/simple;
	bh=8MoZ1d0XyNgN6tYgtpi12mNE2n0Js6b8j98amLW4u4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p66pN5sr0I8EAAeRRAvKpH+BmMJWb7x9nNhn4PXL55QN2INPAevNijhbyc5VpPstL2rYTvQgLSiAlg047bIwXLWPN+9cqDuU2SGQ39u8UOHqzdZUQzr9UoyA12xxP8rX3WZdr4e/gSE0uj9PfrspZH0FQWIEPWIRXQpB7IzLsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUdwSb6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4705C4CEF1;
	Tue,  7 Oct 2025 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879631;
	bh=8MoZ1d0XyNgN6tYgtpi12mNE2n0Js6b8j98amLW4u4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUdwSb6hVjM8l00aXiF9H8j/gszw/N8jyPNSgEN0X1Lm+u2todoQGpw+YogIKtd3Y
	 xNhLxfJhcNak9i4yw5DmujEfdQMhf7Rq/w75vJKnDAyiJZ3Vnqp6Qz4BOjjbUwD5c+
	 E4IuBjkJu0l3uHOeJvVfY7fxH5Zb3z+UxTvQRfZ9aJMkIwdJwZWTyDEPNJipdfd2LY
	 VJCqkN6XlfOvJ6yo9gjkjKm/xA5ZwGqcesxK6tE+1kfP3vH7MSSE0YuQEXhqB+E5p4
	 vkJRyuHNxxXeWMH56IHthOroxgAXHgWmvevQbyfh7Z5MKgLzXgWdm1QdG2KjPkPHRZ
	 zoRoVNhyM4yag==
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
Subject: [PATCH net v2 8/9] selftests: drv-net: pp_alloc_fail: lower traffic expectations
Date: Tue,  7 Oct 2025 16:26:52 -0700
Message-ID: <20251007232653.2099376-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use seen_fails in 2 more places

CC: shuah@kernel.org
CC: johndale@cisco.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/pp_alloc_fail.py    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index fc66b7a7b149..2a51b60df8a1 100755
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
 
 
@@ -89,11 +90,16 @@ from lib.py import cmd, tool, GenerateTraffic
         time.sleep(3)
         s2 = get_stats()
 
-        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 1:
+        seen_fails = s2['rx-alloc-fail'] - s1['rx-alloc-fail']
+        if seen_fails < 1:
             raise KsftSkipEx("Allocation failures not increasing")
-        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 100:
-            raise KsftSkipEx("Allocation increasing too slowly", s2['rx-alloc-fail'] - s1['rx-alloc-fail'],
-                             "packets:", s2['rx-packets'] - s1['rx-packets'])
+        pkts = s2['rx-packets'] - s1['rx-packets']
+        # Expecting one failure per 512 buffers, 3.1x safety margin
+        want_fails = math.floor(pkts / 512 / 3.1)
+        if seen_fails < want_fails:
+            raise KsftSkipEx("Allocation increasing too slowly", seen_fails,
+                             "packets:", pkts)
+        ksft_pr(f"Seen: pkts:{pkts} fails:{seen_fails} (pass thrs:{want_fails})")
 
         # Basic failures are fine, try to wobble some settings to catch extra failures
         check_traffic_flowing()
-- 
2.51.0


