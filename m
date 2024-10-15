Return-Path: <linux-kselftest+bounces-19769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B299F47F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE01F210CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA42281D8;
	Tue, 15 Oct 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHlwaDVq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF822281CB;
	Tue, 15 Oct 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014867; cv=none; b=V93wXyquJMpZ7O4mnbdTledfzUT0XKMKdxJvjMdYixg84VuLLwLPIMqQnhUFcv7xLewoD1kQn3phmPxHUoPZiM9pkaVhJbuw4MzpAen/Gchg8BfRb5e75LhPiDgRjYSYZFiTvbomVVIm2rPwFeydY9kBv5nknAnlpvhx0kKeo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014867; c=relaxed/simple;
	bh=0Hh2QMFBW1aSAnc+4PuGanKNHQGEFuqZ1dsyyv6x/qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7BYiia93SbFJVqNCWWS00cMJKEmsz/9FZ1gxD7OiGhhlR7/9rgR7j5nJM9rCezK1WCGvNeXlFZvv4EuzFxcpy5fboSxscqmvBeyLmyyeB6XjEByNn6Af8UEmPEF4yZagbDGXZuKJRQbBs0jZgopE/eXePnOV4aeZQ2w5IJxwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHlwaDVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B78C4CEC7;
	Tue, 15 Oct 2024 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014866;
	bh=0Hh2QMFBW1aSAnc+4PuGanKNHQGEFuqZ1dsyyv6x/qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHlwaDVqMsH0XSWdMbi7ukCdTnwnWTUbtysf0GmDb8+tO7xXP4p7wnGNR93BTUUGu
	 Xqf/Mh/u5wXUQimx9akVJ1j5V/7ratrbknhc9Ge+zeI23jF6onlF9yAD74eQ8bHfD3
	 2xSpUppkTbrKkIGJeL1reybI1VZklRaXomolyfedL2Flj0ojBAdBmuLOkjHNshTQXg
	 F4UO1WNw7AXplOE/zy+6qe0SpvntzGeVgv0j67yZAgk665LTq9K2/D2pRHyCnNZrs+
	 0xXKJYS3G4CR0UTD5rdGjjx+fWEPKIiVzQqUxXR1vsF8Chc8VYfbomE263vmwKj7HF
	 Rfg3Vul8dw6DQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] selftests/damon: remove tests for DAMON debugfs interface
Date: Tue, 15 Oct 2024 10:54:09 -0700
Message-Id: <20241015175412.60563-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove selftests for the interface, to prevent causing unnecessary test
failures.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore      |  3 -
 tools/testing/selftests/damon/Makefile        | 11 +--
 .../testing/selftests/damon/debugfs_attrs.sh  | 17 ----
 .../debugfs_duplicate_context_creation.sh     | 27 -------
 .../selftests/damon/debugfs_empty_targets.sh  | 21 -----
 .../damon/debugfs_huge_count_read_write.sh    | 22 -----
 .../damon/debugfs_rm_non_contexts.sh          | 19 -----
 .../selftests/damon/debugfs_schemes.sh        | 19 -----
 .../selftests/damon/debugfs_target_ids.sh     | 19 -----
 .../damon/debugfs_target_ids_pid_leak.c       | 68 ----------------
 .../damon/debugfs_target_ids_pid_leak.sh      | 22 -----
 ...fs_target_ids_read_before_terminate_race.c | 80 -------------------
 ...s_target_ids_read_before_terminate_race.sh | 14 ----
 .../selftests/damon/huge_count_read_write.c   | 48 -----------
 14 files changed, 1 insertion(+), 389 deletions(-)
 delete mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
 delete mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 delete mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 delete mode 100644 tools/testing/selftests/damon/huge_count_read_write.c

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index 2ab675fecb6b..2f0297657c81 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-huge_count_read_write
-debugfs_target_ids_read_before_terminate_race
-debugfs_target_ids_pid_leak
 access_memory
 access_memory_even
diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b2a6a5dd1af..fa6042998004 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -1,15 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for damon selftests
 
-TEST_GEN_FILES += huge_count_read_write
-TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
-TEST_GEN_FILES += debugfs_target_ids_pid_leak
 TEST_GEN_FILES += access_memory access_memory_even
 
-TEST_FILES = _chk_dependency.sh _debugfs_common.sh
+TEST_FILES = _chk_dependency.sh
 
 # functionality tests
-TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += sysfs.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
@@ -17,11 +13,6 @@ TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 # regression tests (reproducers of previously found bugs)
-TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
-TEST_PROGS += debugfs_duplicate_context_creation.sh
-TEST_PROGS += debugfs_rm_non_contexts.sh
-TEST_PROGS += debugfs_target_ids_read_before_terminate_race.sh
-TEST_PROGS += debugfs_target_ids_pid_leak.sh
 TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
deleted file mode 100755
index 902e312bca89..000000000000
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test attrs file
-# ===============
-
-file="$DBGFS/attrs"
-orig_content=$(cat "$file")
-
-test_write_succ "$file" "1 2 3 4 5" "$orig_content" "valid input"
-test_write_fail "$file" "1 2 3 4" "$orig_content" "no enough fields"
-test_write_fail "$file" "1 2 3 5 4" "$orig_content" \
-	"min_nr_regions > max_nr_regions"
-test_content "$file" "$orig_content" "1 2 3 4 5" "successfully written"
-echo "$orig_content" > "$file"
diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
deleted file mode 100755
index 4a76e37ef16b..000000000000
--- a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test duplicated context creation
-# ================================
-
-if ! echo foo > "$DBGFS/mk_contexts"
-then
-	echo "context creation failed"
-	exit 1
-fi
-
-if echo foo > "$DBGFS/mk_contexts"
-then
-	echo "duplicate context creation success"
-	exit 1
-fi
-
-if ! echo foo > "$DBGFS/rm_contexts"
-then
-	echo "context deletion failed"
-	exit 1
-fi
-
-exit 0
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
deleted file mode 100755
index effbea33dc16..000000000000
--- a/tools/testing/selftests/damon/debugfs_empty_targets.sh
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test empty targets case
-# =======================
-
-orig_target_ids=$(cat "$DBGFS/target_ids")
-echo "" > "$DBGFS/target_ids"
-
-if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
-then
-	monitor_on_file="$DBGFS/monitor_on_DEPRECATED"
-else
-	monitor_on_file="$DBGFS/monitor_on"
-fi
-
-orig_monitor_on=$(cat "$monitor_on_file")
-test_write_fail "$monitor_on_file" "on" "orig_monitor_on" "empty target ids"
-echo "$orig_target_ids" > "$DBGFS/target_ids"
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
deleted file mode 100755
index 922cadac2950..000000000000
--- a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test huge count read write
-# ==========================
-
-dmesg -C
-
-for file in "$DBGFS/"*
-do
-	./huge_count_read_write "$file"
-done
-
-if dmesg | grep -q WARNING
-then
-	dmesg
-	exit 1
-else
-	exit 0
-fi
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
deleted file mode 100755
index f3ffeb1343cf..000000000000
--- a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test putting non-ctx files/dirs to rm_contexts file
-# ===================================================
-
-dmesg -C
-
-for file in "$DBGFS/"*
-do
-	(echo "$(basename "$f")" > "$DBGFS/rm_contexts") &> /dev/null
-	if dmesg | grep -q BUG
-	then
-		dmesg
-		exit 1
-	fi
-done
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
deleted file mode 100755
index 5b39ab44731c..000000000000
--- a/tools/testing/selftests/damon/debugfs_schemes.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test schemes file
-# =================
-
-file="$DBGFS/schemes"
-orig_content=$(cat "$file")
-
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
-	"$orig_content" "valid input"
-test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
-test_write_succ "$file" "" "$orig_content" "disabling"
-test_write_fail "$file" "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" \
-	"$orig_content" "wrong condition ranges"
-echo "$orig_content" > "$file"
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
deleted file mode 100755
index 49aeabdb0aae..000000000000
--- a/tools/testing/selftests/damon/debugfs_target_ids.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source _debugfs_common.sh
-
-# Test target_ids file
-# ====================
-
-file="$DBGFS/target_ids"
-orig_content=$(cat "$file")
-
-test_write_succ "$file" "1 2 3 4" "$orig_content" "valid input"
-test_write_succ "$file" "1 2 abc 4" "$orig_content" "still valid input"
-test_content "$file" "$orig_content" "1 2" "non-integer was there"
-test_write_succ "$file" "abc 2 3" "$orig_content" "the file allows wrong input"
-test_content "$file" "$orig_content" "" "wrong input written"
-test_write_succ "$file" "" "$orig_content" "empty input"
-test_content "$file" "$orig_content" "" "empty input written"
-echo "$orig_content" > "$file"
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
deleted file mode 100644
index 0cc2eef7d142..000000000000
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Author: SeongJae Park <sj@kernel.org>
- */
-
-#define _GNU_SOURCE
-
-#include <fcntl.h>
-#include <stdbool.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/time.h>
-#include <unistd.h>
-
-#define DBGFS_TARGET_IDS "/sys/kernel/debug/damon/target_ids"
-
-static void write_targetid_exit(void)
-{
-	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
-	char pid_str[128];
-
-	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
-	write(target_ids_fd, pid_str, sizeof(pid_str));
-	close(target_ids_fd);
-	exit(0);
-}
-
-unsigned long msec_timestamp(void)
-{
-	struct timeval tv;
-
-	gettimeofday(&tv, NULL);
-	return tv.tv_sec * 1000UL + tv.tv_usec / 1000;
-}
-
-int main(int argc, char *argv[])
-{
-	unsigned long start_ms;
-	int time_to_run, nr_forks = 0;
-
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <msecs to run>\n", argv[0]);
-		exit(1);
-	}
-	time_to_run = atoi(argv[1]);
-
-	start_ms = msec_timestamp();
-	while (true) {
-		int pid = fork();
-
-		if (pid < 0) {
-			fprintf(stderr, "fork() failed\n");
-			exit(1);
-		}
-		if (pid == 0)
-			write_targetid_exit();
-		wait(NULL);
-		nr_forks++;
-
-		if (msec_timestamp() - start_ms > time_to_run)
-			break;
-	}
-	printf("%d\n", nr_forks);
-	return 0;
-}
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
deleted file mode 100755
index 31fe33c2b032..000000000000
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-before=$(grep "^pid " /proc/slabinfo | awk '{print $2}')
-
-nr_leaks=$(./debugfs_target_ids_pid_leak 1000)
-expected_after_max=$((before + nr_leaks / 2))
-
-after=$(grep "^pid " /proc/slabinfo | awk '{print $2}')
-
-echo > /sys/kernel/debug/damon/target_ids
-
-echo "tried $nr_leaks pid leak"
-echo "number of active pid slabs: $before -> $after"
-echo "(up to $expected_after_max expected)"
-if [ $after -gt $expected_after_max ]
-then
-	echo "maybe pids are leaking"
-	exit 1
-else
-	exit 0
-fi
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
deleted file mode 100644
index b06f52a8ce2d..000000000000
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Author: SeongJae Park <sj@kernel.org>
- */
-#define _GNU_SOURCE
-
-#include <fcntl.h>
-#include <stdbool.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <time.h>
-#include <unistd.h>
-
-#define DBGFS_MONITOR_ON "/sys/kernel/debug/damon/monitor_on_DEPRECATED"
-#define DBGFS_TARGET_IDS "/sys/kernel/debug/damon/target_ids"
-
-static void turn_damon_on_exit(void)
-{
-	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
-	int monitor_on_fd = open(DBGFS_MONITOR_ON, O_RDWR);
-	char pid_str[128];
-
-	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
-	write(target_ids_fd, pid_str, sizeof(pid_str));
-	write(monitor_on_fd, "on\n", 3);
-	close(target_ids_fd);
-	close(monitor_on_fd);
-	usleep(1000);
-	exit(0);
-}
-
-static void try_race(void)
-{
-	int target_ids_fd = open(DBGFS_TARGET_IDS, O_RDWR);
-	int pid = fork();
-	int buf[256];
-
-	if (pid < 0) {
-		fprintf(stderr, "fork() failed\n");
-		exit(1);
-	}
-	if (pid == 0)
-		turn_damon_on_exit();
-	while (true) {
-		int status;
-
-		read(target_ids_fd, buf, sizeof(buf));
-		if (waitpid(-1, &status, WNOHANG) == pid)
-			break;
-	}
-	close(target_ids_fd);
-}
-
-static inline uint64_t ts_to_ms(struct timespec *ts)
-{
-	return (uint64_t)ts->tv_sec * 1000 + (uint64_t)ts->tv_nsec / 1000000;
-}
-
-int main(int argc, char *argv[])
-{
-	struct timespec start_time, now;
-	int runtime_ms;
-
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <runtime in ms>\n", argv[0]);
-		exit(1);
-	}
-	runtime_ms = atoi(argv[1]);
-	clock_gettime(CLOCK_MONOTONIC, &start_time);
-	while (true) {
-		try_race();
-		clock_gettime(CLOCK_MONOTONIC, &now);
-		if (ts_to_ms(&now) - ts_to_ms(&start_time) > runtime_ms)
-			break;
-	}
-	return 0;
-}
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
deleted file mode 100755
index fc793c4c9aea..000000000000
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-dmesg -C
-
-./debugfs_target_ids_read_before_terminate_race 5000
-
-if dmesg | grep -q dbgfs_target_ids_read
-then
-	dmesg
-	exit 1
-else
-	exit 0
-fi
diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
deleted file mode 100644
index a6fe0689f88d..000000000000
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Author: SeongJae Park <sj@kernel.org>
- */
-
-#include <fcntl.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdio.h>
-
-#pragma GCC diagnostic push
-#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
-/* Ignore read(2) overflow and write(2) overread compile warnings */
-#pragma GCC diagnostic ignored "-Wstringop-overread"
-#pragma GCC diagnostic ignored "-Wstringop-overflow"
-#endif
-
-void write_read_with_huge_count(char *file)
-{
-	int filedesc = open(file, O_RDWR);
-	char buf[25];
-	int ret;
-
-	printf("%s %s\n", __func__, file);
-	if (filedesc < 0) {
-		fprintf(stderr, "failed opening %s\n", file);
-		exit(1);
-	}
-
-	write(filedesc, "", 0xfffffffful);
-	perror("after write: ");
-	ret = read(filedesc, buf, 0xfffffffful);
-	perror("after read: ");
-	close(filedesc);
-}
-
-#pragma GCC diagnostic pop
-
-int main(int argc, char *argv[])
-{
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
-		exit(1);
-	}
-	write_read_with_huge_count(argv[1]);
-
-	return 0;
-}
-- 
2.39.5


