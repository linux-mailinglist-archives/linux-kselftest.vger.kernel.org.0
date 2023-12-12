Return-Path: <linux-kselftest+bounces-1716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84C80F724
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524531F21557
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00D63592;
	Tue, 12 Dec 2023 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFG5wkkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C663561;
	Tue, 12 Dec 2023 19:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0450C433C8;
	Tue, 12 Dec 2023 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410508;
	bh=phkCbBjwGt+n6h2sfVSgzetITkrs0kG9itajhDj2yNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFG5wkkBOF2x9j9gyGGLubTMYkzkbJstAmoQ25ym5KEkYMW7LQSg7VlkHT0VsBewq
	 PNQQrckZItir6nXXD95z1008764sdQl/AiClTuGyEzxA+qnRMrnO9PCNHTged7xwEN
	 qCSwu9EgddoVUVOAvIS6hDQt1O2WtLZvpLEv08pY3pxg/Preb3AwtoWheHB9hto/QU
	 r/phUw+qZQTWEpXEvJVsB79kWl/o/4LLOYYtZJYxFkXkSaVxiOMAmTyP6xAwrhuHSp
	 BXq//Pn/qh8xeJ9APQLYtPyVUMvuu0BYixIg+JQAUvz+QOwPAJVfOO7SECXW7UgdL1
	 XHNxiSAwN4dxw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] selftests/damon: add a test for update_schemes_tried_regions sysfs command
Date: Tue, 12 Dec 2023 19:48:09 +0000
Message-Id: <20231212194810.54457-5-sj@kernel.org>
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

Add a selftest for verifying the accuracy of DAMON's access monitoring
functionality.  The test starts a program of artificial access pattern,
monitor the access pattern using DAMON, and check if DAMON finds
expected amount of hot data region (working set size) with only
acceptable error rate.

Note that the acceptable error rate is set with only naive assumptions
and small number of tests.  Hence failures of the test may not always
mean DAMON is broken.  Rather than that, those could be a signal to
better understand the real accuracy level of DAMON in wider
environments.  Based on further finding, we could optimize DAMON or
adjust the expectation of the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +
 tools/testing/selftests/damon/access_memory.c | 41 ++++++++++++++
 ...te_schemes_tried_regions_wss_estimation.py | 55 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index b71247ba7196..90ffafc42c5e 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -2,6 +2,7 @@
 # Makefile for damon selftests
 
 TEST_GEN_FILES += huge_count_read_write
+TEST_GEN_FILES += access_memory
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
@@ -9,6 +10,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testing/selftests/damon/access_memory.c
new file mode 100644
index 000000000000..585a2fa54329
--- /dev/null
+++ b/tools/testing/selftests/damon/access_memory.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Artificial memory access program for testing DAMON.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+int main(int argc, char *argv[])
+{
+	char **regions;
+	clock_t start_clock;
+	int nr_regions;
+	int sz_region;
+	int access_time_ms;
+	int i;
+
+	if (argc != 4) {
+		printf("Usage: %s <number> <size (bytes)> <time (ms)>\n",
+				argv[0]);
+		return -1;
+	}
+
+	nr_regions = atoi(argv[1]);
+	sz_region = atoi(argv[2]);
+	access_time_ms = atoi(argv[3]);
+
+	regions = malloc(sizeof(*regions) * nr_regions);
+	for (i = 0; i < nr_regions; i++)
+		regions[i] = malloc(sz_region);
+
+	for (i = 0; i < nr_regions; i++) {
+		start_clock = clock();
+		while ((clock() - start_clock) * 1000 / CLOCKS_PER_SEC <
+				access_time_ms)
+			memset(regions[i], i, 1024 * 1024 * 10);
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
new file mode 100755
index 000000000000..cdbf19b442c9
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    # access two 10 MiB memory regions, 2 second per each
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory', '2', '%d' % sz_region, '2000'])
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
+                        # >= 25% access rate, >= 200ms age
+                        nr_accesses=[5, 20], age=[2, 2**64 - 1]))] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdmaond start failed: %s' % err)
+        exit(1)
+
+    wss_collected = []
+    while proc.poll() == None:
+        time.sleep(0.1)
+        err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
+        if err != None:
+            print('tried bytes update failed: %s' % err)
+            exit(1)
+
+        wss_collected.append(
+                kdamonds.kdamonds[0].contexts[0].schemes[0].tried_bytes)
+
+    wss_collected.sort()
+    acceptable_error_rate = 0.2
+    for percentile in [50, 75]:
+        sample = wss_collected[int(len(wss_collected) * percentile / 100)]
+        error_rate = abs(sample - sz_region) / sz_region
+        print('%d-th percentile (%d) error %f' %
+                (percentile, sample, error_rate))
+        if error_rate > acceptable_error_rate:
+            print('the error rate is not acceptable (> %f)' %
+                    acceptable_error_rate)
+            print('samples are as below')
+            print('\n'.join(['%d' % wss for wss in wss_collected]))
+            exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1


