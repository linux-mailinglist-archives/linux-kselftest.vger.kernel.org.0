Return-Path: <linux-kselftest+bounces-12721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B5916FCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D71C230E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655717C226;
	Tue, 25 Jun 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZW6FvAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945D17BB3C;
	Tue, 25 Jun 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338747; cv=none; b=MZ4YTCksAIvGreg1yE818O7hi2QZly4Lq5yrN/vBLPlRSUwayhCHxYBWIp0W5xUihRFXWDFzh+EOyJO8zGNt/4PMHYeQO0ISr2lCqtJncKnGzZlzzOm1knpWz2A5HZTn4okgmhVwLPBC/GelShZvZ1PQTRpnEAdb0syh8WR1lQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338747; c=relaxed/simple;
	bh=IuEbQPKkXzrPZK6YAlgDSnlBOl1pA1OTrf32W27fHRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YecqTQ9kijv8d1rAh+8Dl9vBUa/X5u5Mx7O+isIGAYGxnZL00jtjBlAtxcRcqqS/SZvO6XtEVpz1eAzkSqFcFi0Vyamz1hFAQDvPbC55GxlVnzmXW1xhdIb+zWeHPojge+ZbOTjxAsz+t3i+K9spSLHrq+WujtlZqpMj/vgE5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZW6FvAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934D2C32781;
	Tue, 25 Jun 2024 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338747;
	bh=IuEbQPKkXzrPZK6YAlgDSnlBOl1pA1OTrf32W27fHRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZW6FvAsRy1TtK+Ximbxp4cNzEldF+GHKTE6xKDuX6ScVnrZC1O8tsgfOX9GYoVHZ
	 Eqm1ERLccOip5xxxXx6epCVzX+wTcpualFf28d5l4MKI4QRCrCSzencV60QSGuBLOi
	 7Csl0c8aIY5TAC73Z4Wdb7lqxJ41hE6H1JselBoSUR8yntWrvIXHcjkXmwhX3V7zYr
	 IunlcjQV6pwFuLTJyuegnSY1bux56hSnFNF7v7c2Au875//9QNeWKzB8v0JRYK+fzN
	 il/nYtFa5C4OqrzlY9CqCeCB3aCOwpYpw7cRrZNshhmbRZISGsFW/9yCXEa7HUxtmM
	 OIDlfa3WmwD9Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] selftests/damon: implement DAMOS tried regions test
Date: Tue, 25 Jun 2024 11:05:34 -0700
Message-Id: <20240625180538.73134-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a test for DAMOS tried regions command of DAMON sysfs
interface.  It ensures the expected number of monitoring regions are
created using an artificial memory access pattern generator program.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../selftests/damon/damos_tried_regions.py    | 65 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/damon/damos_tried_regions.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 7b972b5cf487..356b4e9a515d 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += sysfs.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
+TEST_PROGS += damos_tried_regions.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 # regression tests (reproducers of previously found bugs)
diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
new file mode 100644
index 000000000000..3b347eb28bd2
--- /dev/null
+++ b/tools/testing/selftests/damon/damos_tried_regions.py
@@ -0,0 +1,65 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    # repeatedly access even-numbered ones in 14 regions of 10 MiB size
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory_even', '14', '%d' % sz_region])
+
+    # stat every monitored regions
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(action='stat',
+                    )] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err is not None:
+        proc.terminate()
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    collected_nr_regions = []
+    while proc.poll() is None:
+        time.sleep(0.1)
+        err = kdamonds.kdamonds[0].update_schemes_tried_regions()
+        if err is not None:
+            proc.terminate()
+            print('tried regions update failed: %s' % err)
+            exit(1)
+
+        scheme = kdamonds.kdamonds[0].contexts[0].schemes[0]
+        if scheme.tried_regions is None:
+            proc.terminate()
+            print('tried regions is not collected')
+            exit(1)
+
+        nr_tried_regions = len(scheme.tried_regions)
+        if nr_tried_regions <= 0:
+            proc.terminate()
+            print('tried regions is not created')
+            exit(1)
+        collected_nr_regions.append(nr_tried_regions)
+        if len(collected_nr_regions) > 10:
+            break
+    proc.terminate()
+
+    collected_nr_regions.sort()
+    sample = collected_nr_regions[4]
+    print('50-th percentile nr_regions: %d' % sample)
+    print('expectation (>= 14) is %s' % 'met' if sample >= 14 else 'not met')
+    if collected_nr_regions[4] < 14:
+        print('full nr_regions:')
+        print('\n'.join(collected_nr_regions))
+        exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2


