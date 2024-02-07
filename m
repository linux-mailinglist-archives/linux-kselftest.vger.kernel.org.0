Return-Path: <linux-kselftest+bounces-4281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851284D308
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF9B27BE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5212A160;
	Wed,  7 Feb 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb2oXTnE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522212A140;
	Wed,  7 Feb 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337906; cv=none; b=l1dbTGVfBu2+1H2SdADQKFQ+0yDcgWYdtyqPzQropeIJ3f4hg2Yx6VJVAviTZZgFT08b/PSO4XqDM34DNo0HO+IvmANdfLaDaYIBYFij20W1Rr0jtuIAee2ZWaww5t/zF8aF4oddtbaxVBzGqNfOawwVPUorQm7FUFnz0gDvqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337906; c=relaxed/simple;
	bh=S70M2GZNqYMqWcESwYxGcEzhW76DUgm+kbbaqJbCpdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeALtH/y1Xj2C73EwkSpgd+DaoRE8hKm9cFnnLDIJAFPxQXmJbdtgo+/sqoM/yvEk12M0dE+jkbpObcxwz5pYaEPLUMU5UraTM/536O6QNYFS54aY9YCVzDp9bEkqW5d9AyH+btsSn9P0fhs8S34WYkLAHynLHh87ELKjyBn3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb2oXTnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF18C433C7;
	Wed,  7 Feb 2024 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337905;
	bh=S70M2GZNqYMqWcESwYxGcEzhW76DUgm+kbbaqJbCpdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kb2oXTnE6R6F4wSlva8PlQVqRsigPUXebwXQrnwij+JJ0C0b0PBPFATsjYGBrIqnm
	 9Y2oe/yFwWE4brv0188AL9S1F+hjHdIUZm34lv7g1vdMpmwnxAMQhkPbKuQbS9GeEs
	 ejyeJRqNduFrSwmajR92vuwy8PrCVze+OK1zr9vlBtzzAdpTxqOOa4VAiSUjTKq2YC
	 58Rkx9c6FpQ0lTpEpryr9vph4mf6eMRtpoOS5ZCfcJqfiLSG4GSBVZQwWw87gxDwuZ
	 SOeM4Q42U078d5I4K5zVz+Y9XOZr/6+TQ8P2g3eOdcd9gStaXDIkw9JP1H5abEw1cb
	 BjLSZNNWyOoXw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] selftests/damon: add a test for a race between target_ids_read() and dbgfs_before_terminate()
Date: Wed,  7 Feb 2024 12:31:32 -0800
Message-Id: <20240207203134.69976-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207203134.69976-1-sj@kernel.org>
References: <20240207203134.69976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 34796417964b ("mm/damon/dbgfs: protect targets destructions with
kdamond_lock") fixed a race of DAMON debugfs interface.  Specifically,
the race was happening between target_ids_read() and
dbgfs_before_terminate().  Add a test for the issue to prevent the
problem from accidentally recurring.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore      |  1 +
 tools/testing/selftests/damon/Makefile        |  2 +
 ...fs_target_ids_read_before_terminate_race.c | 80 +++++++++++++++++++
 ...s_target_ids_read_before_terminate_race.sh | 14 ++++
 4 files changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
 create mode 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index c6c2965a6607..7d6c6e062be7 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 huge_count_read_write
+debugfs_target_ids_read_before_terminate_race
diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index b545fedafb3b..8a3a8df003db 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -2,6 +2,7 @@
 # Makefile for damon selftests
 
 TEST_GEN_FILES += huge_count_read_write
+TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
 TEST_GEN_FILES += access_memory
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
@@ -9,6 +10,7 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
+TEST_PROGS += debugfs_target_ids_read_before_terminate_race.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
new file mode 100644
index 000000000000..b06f52a8ce2d
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#define DBGFS_MONITOR_ON "/sys/kernel/debug/damon/monitor_on_DEPRECATED"
+#define DBGFS_TARGET_IDS "/sys/kernel/debug/damon/target_ids"
+
+static void turn_damon_on_exit(void)
+{
+	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
+	int monitor_on_fd = open(DBGFS_MONITOR_ON, O_RDWR);
+	char pid_str[128];
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	write(target_ids_fd, pid_str, sizeof(pid_str));
+	write(monitor_on_fd, "on\n", 3);
+	close(target_ids_fd);
+	close(monitor_on_fd);
+	usleep(1000);
+	exit(0);
+}
+
+static void try_race(void)
+{
+	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
+	int pid = fork();
+	int buf[256];
+
+	if (pid < 0) {
+		fprintf(stderr, "fork() failed\n");
+		exit(1);
+	}
+	if (pid == 0)
+		turn_damon_on_exit();
+	while (true) {
+		int status;
+
+		read(target_ids_fd, buf, sizeof(buf));
+		if (waitpid(-1, &status, WNOHANG) == pid)
+			break;
+	}
+	close(target_ids_fd);
+}
+
+static inline uint64_t ts_to_ms(struct timespec *ts)
+{
+	return (uint64_t)ts->tv_sec * 1000 + (uint64_t)ts->tv_nsec / 1000000;
+}
+
+int main(int argc, char *argv[])
+{
+	struct timespec start_time, now;
+	int runtime_ms;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <runtime in ms>\n", argv[0]);
+		exit(1);
+	}
+	runtime_ms = atoi(argv[1]);
+	clock_gettime(CLOCK_MONOTONIC, &start_time);
+	while (true) {
+		try_race();
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		if (ts_to_ms(&now) - ts_to_ms(&start_time) > runtime_ms)
+			break;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
new file mode 100755
index 000000000000..fc793c4c9aea
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+dmesg -C
+
+./debugfs_target_ids_read_before_terminate_race 5000
+
+if dmesg | grep -q dbgfs_target_ids_read
+then
+	dmesg
+	exit 1
+else
+	exit 0
+fi
-- 
2.39.2


