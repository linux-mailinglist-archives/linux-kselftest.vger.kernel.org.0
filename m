Return-Path: <linux-kselftest+bounces-1717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35080F725
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A568E282036
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5C63594;
	Tue, 12 Dec 2023 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnzxvu7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90463561;
	Tue, 12 Dec 2023 19:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE7AC433CB;
	Tue, 12 Dec 2023 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410510;
	bh=oqY4K6jG5BE7MOa8w7xZ5OE+AG4WMHalMWId0VgXocY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnzxvu7BVIdvv9Ic+qurUQy08ciyvLKjizQmFRbi04fR8a3sqd6LqpKeq6mcwP8Zv
	 eY8cV+zJH2kwV7qi4LahoFIcN6NrYshFn3VFzeTRsSaFBX1dabyreTm1nT1+HBv1GC
	 ZnNAHfBSfmGfvpivfX7vkQPeAH/oaxqWKKV8I3s0HzfGGxwSQPV/XYGGYkCmjERBzT
	 5KPrWUvNUwetqb/syAj2X7gA6u/ovpEZvvE+CbPXzeHzsPZxyuFCPIkubXJ67Wh2sT
	 9/6duqy8LuyB7t1zMc27sMWSH0zgFXE3L196jMplrgOlGxLivrxPKOBgWnMkbQULsF
	 nlhSNbD+4hbWg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] selftests/damon: add a test for update_schemes_tried_regions hang bug
Date: Tue, 12 Dec 2023 19:48:10 +0000
Message-Id: <20231212194810.54457-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212194810.54457-1-sj@kernel.org>
References: <20231212194810.54457-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for reproducing the update_schemes_tried_{regions,bytes}
command-causing indefinite hang bug that fixed by commit 7d6fa31a2fd7
("mm/damon/sysfs-schemes: add timeout for
update_schemes_tried_regions"), to avoid mistakenly re-introducing the
bug.  Refer to the fix commit for more details of the bug.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 ...sysfs_update_schemes_tried_regions_hang.py | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 90ffafc42c5e..8a1cc2bf1864 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
new file mode 100755
index 000000000000..8c690ba1a573
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    proc = subprocess.Popen(['sleep', '2'])
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
+                        nr_accesses=[200, 200]))] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdmaond start failed: %s' % err)
+        exit(1)
+
+    while proc.poll() == None:
+        err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
+        if err != None:
+            print('tried bytes update failed: %s' % err)
+            exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1


