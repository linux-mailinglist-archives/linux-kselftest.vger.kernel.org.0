Return-Path: <linux-kselftest+bounces-4282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C984D30A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2001C2496C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E312B15A;
	Wed,  7 Feb 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou2UWhF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668E12AAF6;
	Wed,  7 Feb 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337906; cv=none; b=FpN/Y+Dbp93F6yCbjnWwAonJiA1I6SgiE84hsOYbUTu8YFg9mu8LMLJo1usvpT72/CypjwdJg5gaYLVAYFtRXeuGmLlvXE9wgM07j4h1Cafb2s/E9JkjASsCqo5sFOsJxnAPKnGvOeWNZlBJSTTT1a6uzjkesfx0vYjVrFWnul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337906; c=relaxed/simple;
	bh=hilY7j3dbTrTcHQNZ5cH9hllN5vVoaZDnsr9bRpaZZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBGxHFtfjyI5itmAHYVftt62DVXZP7vD23DVCBbnsVI7FkImex4WfYF/gPR+X+EzI8eOnlCXa7TUGsnoH0QhwYR4lUwnWXNREsXEWjZPiDBkvG5jdmygQJawY0SSOcY5JUiIsa6z3B2INiZUIdBqmpjDrzvy3C1qGxeUNCGBK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou2UWhF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C72C43601;
	Wed,  7 Feb 2024 20:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337906;
	bh=hilY7j3dbTrTcHQNZ5cH9hllN5vVoaZDnsr9bRpaZZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ou2UWhF7rKY/SOJPhENMHQfU07MoTtvz7MvwRRiYyi+LjIzxD5rbLHTVaXLNHZNR9
	 lFR6S9udTLIzBtTPoxRQGoEdVNalxZkr/elBolMd/SfH5QFGWjwos7+/sf2oAiOq3O
	 a6wJNdJoaYJLL6Pv7h+oUyC+TN00MUk5ipl7S00Kd4NrisZHeGUSddyvn2IdWwCrMQ
	 hdF+ZGVnRCq6QPicoYIQAGTLPPsGo5wDuRIkS4FTPC6TdAnAI6C8OEOEiHLUXNw9HY
	 rZHgPKwBjJ/k5VGnsnvlP2zcb9HXC8V/mPlVuA6CTPFbN9CplEBU2O9p3H+PGt2+3J
	 356gekiMFzpVg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] selftests/damon: add a test for the pid leak of dbgfs_target_ids_write()
Date: Wed,  7 Feb 2024 12:31:33 -0800
Message-Id: <20240207203134.69976-8-sj@kernel.org>
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

Commit ebb3f994dd92 ("mm/damon/dbgfs: fix 'struct pid' leaks in
'dbgfs_target_ids_write()'") fixes a pid leak bug in DAMON debugfs
interface, namely dbgfs_target_ids_write() function.  Add a selftest for
the issue to prevent the problem from mistakenly recurring.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore      |  1 +
 tools/testing/selftests/damon/Makefile        |  2 +
 .../damon/debugfs_target_ids_pid_leak.c       | 68 +++++++++++++++++++
 .../damon/debugfs_target_ids_pid_leak.sh      | 22 ++++++
 4 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
 create mode 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index 7d6c6e062be7..d861701f0327 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
+debugfs_target_ids_pid_leak
diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 8a3a8df003db..789d6949c247 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -3,6 +3,7 @@
 
 TEST_GEN_FILES += huge_count_read_write
 TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
+TEST_GEN_FILES += debugfs_target_ids_pid_leak
 TEST_GEN_FILES += access_memory
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
@@ -11,6 +12,7 @@ TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += debugfs_target_ids_read_before_terminate_race.sh
+TEST_PROGS += debugfs_target_ids_pid_leak.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
new file mode 100644
index 000000000000..0cc2eef7d142
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#define DBGFS_TARGET_IDS "/sys/kernel/debug/damon/target_ids"
+
+static void write_targetid_exit(void)
+{
+	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
+	char pid_str[128];
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	write(target_ids_fd, pid_str, sizeof(pid_str));
+	close(target_ids_fd);
+	exit(0);
+}
+
+unsigned long msec_timestamp(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return tv.tv_sec * 1000UL + tv.tv_usec / 1000;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long start_ms;
+	int time_to_run, nr_forks = 0;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <msecs to run>\n", argv[0]);
+		exit(1);
+	}
+	time_to_run = atoi(argv[1]);
+
+	start_ms = msec_timestamp();
+	while (true) {
+		int pid = fork();
+
+		if (pid < 0) {
+			fprintf(stderr, "fork() failed\n");
+			exit(1);
+		}
+		if (pid == 0)
+			write_targetid_exit();
+		wait(NULL);
+		nr_forks++;
+
+		if (msec_timestamp() - start_ms > time_to_run)
+			break;
+	}
+	printf("%d\n", nr_forks);
+	return 0;
+}
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
new file mode 100755
index 000000000000..31fe33c2b032
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+before=$(grep "^pid " /proc/slabinfo | awk '{print $2}')
+
+nr_leaks=$(./debugfs_target_ids_pid_leak 1000)
+expected_after_max=$((before + nr_leaks / 2))
+
+after=$(grep "^pid " /proc/slabinfo | awk '{print $2}')
+
+echo > /sys/kernel/debug/damon/target_ids
+
+echo "tried $nr_leaks pid leak"
+echo "number of active pid slabs: $before -> $after"
+echo "(up to $expected_after_max expected)"
+if [ $after -gt $expected_after_max ]
+then
+	echo "maybe pids are leaking"
+	exit 1
+else
+	exit 0
+fi
-- 
2.39.2


