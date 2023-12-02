Return-Path: <linux-kselftest+bounces-998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F58018B6
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6101C1F2110B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14845193;
	Sat,  2 Dec 2023 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgHf7Eo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECCEBE;
	Sat,  2 Dec 2023 00:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA99CC433CD;
	Sat,  2 Dec 2023 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475693;
	bh=0o1OidTQa+jBmmayVqOJ5Gh8ghc1rg4/WI7HWKTJJqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgHf7Eo3aY6hqilQ6vhoUxZZ0Dc2Zeu3gG4+W5pxm7RRYGGlX6sRPfdd19Ii+dGRU
	 3b9OCW1b8U6a+3cQY+1RZWwDJqfWWXvPCDWx/MFMLLBT0neQjeR8jtY/JV+Z7x03qx
	 dYbsUMgMGYcmq39jD6IJoUmkxwT4DwdLsNjOBAXOkWcfOuei2nWCGBKrbOs8JoIrY4
	 OieJhlPmDjSE47hOJ9n1ygykcGnoQsGp/C/DuZ20al10JgSmXbU7X+xkKJOxRh51Ie
	 kBxeDsvx0mPcaXCorB5l6mp4p/vYCUQ0vBhkwzggPNMJ8/arJWGiklqERGlbq77zk6
	 3PXJSOLrvCU5A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] selftests/damon: add a test for update_schemes_tried_regions hang bug
Date: Sat,  2 Dec 2023 00:08:06 +0000
Message-Id: <20231202000806.46210-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202000806.46210-1-sj@kernel.org>
References: <20231202000806.46210-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update_schemees_tried_{regions,bytes} command was able to be
indefinitely hang in some corner cases.  It has fixed by introducing a
timeout for the command[1].  Add a test for the corner case to not
introduce the problem again.

[1] https://lore.kernel.org/damon/20231124213840.39157-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 ...sysfs_update_schemes_tried_regions_hang.py | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 1363987709c6..d90bdba28ff4 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 TEST_PROGS += dbgfs_target_ids_read_before_terminate_race.sh
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
new file mode 100755
index 000000000000..14187be3b004
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon
+
+def main():
+    proc = subprocess.Popen(['sleep', '2'])
+    kdamonds = _damon.Kdamonds([_damon.Kdamond(
+            contexts=[_damon.DamonCtx(
+                ops='vaddr',
+                targets=[_damon.DamonTarget(pid=proc.pid)],
+                schemes=[_damon.Damos(
+                    access_pattern=_damon.DamosAccessPattern(
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


