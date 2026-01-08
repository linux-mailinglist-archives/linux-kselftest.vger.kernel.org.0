Return-Path: <linux-kselftest+bounces-48568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42414D067DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6C3F305EE5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DE333CEAF;
	Thu,  8 Jan 2026 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmZmo0iL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE168338911
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913018; cv=none; b=UjFVRRuynF+SaSVx6e3eToJH+I2H+OoKZl8X+D/cvWDds9JfkVAqKqoBAkQvLHWBN2n0dVFg0BFOzz1FjLpqvxePqc+kWsAFDbDRobEZTOFencIRxwv6+Xb90WhnDEdyny39K4giQmSqAFgQ42oTVEb2lzLcbz2Yp1TqX+eRbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913018; c=relaxed/simple;
	bh=A9jI17fcs31/t1iRyFhUJM+zf4m3JOvyrT8NoYE4jB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m8uGi9MD/Z7q1y9sYT7AehuntPRTAF2KrV8DGj4yyuALC5bm21e43CAzrVmsbibiSDiI0o/yHrvw2U7JXZvPDhqSji5ZDbxt9CZHNZiVqSjU50hQ6eJMIoDb1E5+pFsgO17hm7m90ilpd7Y8BtGWJxPG+MuTkbUAPG28aesHSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmZmo0iL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f3b5411c7so1238001c88.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767913015; x=1768517815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhp4aBOWkHAoDobmjqBAbtC3QTUVVj6dv/kGDpJATC4=;
        b=VmZmo0iLvg9ip5jcADbfA1WEpWiPlQW8+V92H9gd1tXsEAIsDcKx0hPOo1e6B1xMYH
         8E4YoEVGpIIU6F+slpdWSuDm4jKDUedKSE3cB+m5zDhTlwnUHbUl3bNg1rHWIExhLqiX
         yZhDJXpqF218eodAS9MF7YF9VZFF+HmOYWdApaRu6LPJOIkiBvfOdugbSBCNyNs/qslT
         rn3FYDilXMsBW5nJiJ1+CoS/arNH0wTvuwRseb6NoKj6XQMGy5oCxqFrK4kQefyU++vy
         nlXmza5FlfUeCCqVBUNhQHF9yVIbsLN4GkcZXQSVncj38f9fwNRQrh/f8aAdIYjDQEGm
         fHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913015; x=1768517815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhp4aBOWkHAoDobmjqBAbtC3QTUVVj6dv/kGDpJATC4=;
        b=EYIj3uJOr1XuklrWYvtdUpMOl1nofaq+fzOSYwQzL/KYQHoUGRi5NMxwl4atXsTC3D
         PfPJKR+J6hClsACBraFuOVa6y3H5bnpmKSl7s7cCGwNhVRPTjN7dcPlHruJPqa9pAH/a
         UBuWjOiuvIRHHdQOfgV+OIcTAdX65C8f+BpzvrcOmBytN76AgC7iTkwqKZG6o3lLim4s
         7Om60yEPh3d1KgnN0uLZgwFLD2iYD7WyXg4xN+2PCuPLy3ByIKqUeOLyiy11IbDvGiC8
         mTP/BIwvS4bFQ5KkZSDbHsJk1xdeo2CU4yfU/p5tC5HxuBDehjwn5csLuexKrlxr9ioi
         G7xA==
X-Forwarded-Encrypted: i=1; AJvYcCV7unTrxNYRYilTsouSih8L6YhTl+12/xjac5jQDZVdy9PjbpOaV/tWEm9MDsxjHjEVmW8OVcghw1JLSJ3fjuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlXgu5CkROU6XK3l7i0GvdFw2CmgAZ66b0GGzeg2m8Dh4wYQJ
	qIWH5TgaR6CCMm+jUlZSwJAXGNuCiveAn4IjQBjuz8uoNcQH6iU9XEdbTmkc3UB+g6fgK/PCQyx
	xm3tLaH7tSyhtxQ==
X-Google-Smtp-Source: AGHT+IGGJ3gGsTBzfEEUlqWrpntUe9wgzFyGAg3KxYBa7uLrvMBFpxhg/XQEcGsUPspCiatDsHXq8OHCrduk1g==
X-Received: from dlbtx2.prod.google.com ([2002:a05:7022:fc02:b0:11b:1a9a:d2e8])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2494:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-121f8ad1c96mr6785720c88.18.1767913014880;
 Thu, 08 Jan 2026 14:56:54 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:20 -0800
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-4-wusamuel@google.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add tests for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sets up the framework to test wakeup_sources iterators using BPF, and
adds a few basic tests.

Adds several helper functions that for grabbing and releasing a
wakelock, abstracting out key functions to setup a framework for testing
wakeup_sources.

Additionally, adds 3 tests:
1. check_active_count: Checks that stats related to active_count are
   properly set after several lock/unlock cycles
2. check_sleep_times: Checks that time accounting related to sleep are
   properly calculated
3. check_no_infinite_reads: Checks that the iterator traversal returns
   NULL at the end

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 281 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  |  70 +++++
 3 files changed, 352 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e3c185..c12c5e04b81f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
+CONFIG_PM_WAKELOCKS=y
 CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
new file mode 100644
index 000000000000..31729f11585e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include "wakeup_source_iter.skel.h"
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Sleep for 10ms to ensure active time is > 0 after converting ns to ms*/
+#define TEST_SLEEP_US 10000
+#define TEST_SLEEP_MS (TEST_SLEEP_US / 1000)
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+static const char test_ws_name[] = "bpf_selftest_ws";
+static bool test_ws_created;
+
+/*
+ * Creates a new wakeup source by writing to /sys/power/wake_lock.
+ * This lock persists until explicitly unlocked.
+ */
+static int lock_ws(const char *name)
+{
+	int fd;
+	ssize_t bytes;
+
+	fd = open("/sys/power/wake_lock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
+		return -1;
+
+	bytes = write(fd, name, strlen(name));
+	close(fd);
+	if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Destroys the ws by writing the same name to /sys/power/wake_unlock.
+ */
+static void unlock_ws(const char *name)
+{
+	int fd;
+
+	fd = open("/sys/power/wake_unlock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_unlock"))
+		goto cleanup;
+
+	write(fd, name, strlen(name));
+
+cleanup:
+	if (fd)
+		close(fd);
+}
+
+/*
+ * Setups for testing ws iterators. Will run once prior to suite of tests.
+ */
+static int setup_test_ws(void)
+{
+	if (lock_ws(test_ws_name))
+		return -1;
+	test_ws_created = true;
+
+	return 0;
+}
+
+/*
+ * Tears down and cleanups testing ws iterators. WIll run once after the suite
+ * of tests.
+ */
+static void teardown_test_ws(void)
+{
+	if (!test_ws_created)
+		return;
+	unlock_ws(test_ws_name);
+	test_ws_created = false;
+}
+
+struct WakeupSourceInfo {
+	char name[WAKEUP_SOURCE_NAME_LEN];
+	unsigned long active_count;
+	long active_time_ms;
+	unsigned long event_count;
+	unsigned long expire_count;
+	long last_change_ms;
+	long max_time_ms;
+	long prevent_sleep_time_ms;
+	long total_time_ms;
+	unsigned long wakeup_count;
+};
+
+/*
+ * Reads and parses one wakeup_source record from the iterator file.
+ * A record is a single space-delimited line.
+ * Returns true on success, false on EOF. Asserts internally on errors.
+ */
+static bool read_ws_info(FILE *iter_file, struct WakeupSourceInfo *ws_info,
+			 char **line)
+{
+	size_t linesize;
+	int items;
+
+	if (getline(line, &linesize, iter_file) == -1)
+		return false;
+
+	(*line)[strcspn(*line, "\n")] = 0;
+
+	items = sscanf(*line, "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu",
+		       ws_info->name, &ws_info->active_count,
+		       &ws_info->active_time_ms, &ws_info->event_count,
+		       &ws_info->expire_count, &ws_info->last_change_ms,
+		       &ws_info->max_time_ms, &ws_info->prevent_sleep_time_ms,
+		       &ws_info->total_time_ms, &ws_info->wakeup_count);
+
+	if (!ASSERT_EQ(items, 10, "read wakeup source info"))
+		return false;
+
+	if (!ASSERT_LT(strlen(ws_info->name), WAKEUP_SOURCE_NAME_LEN,
+		       "name length"))
+		return false;
+
+	return true;
+}
+
+static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *iter_fd,
+			      FILE **iter_file)
+{
+	*iter_fd = bpf_iter_create(
+			bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
+		return -1;
+
+	*iter_file = fdopen(*iter_fd, "r");
+	if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
+		return -1;
+
+	return 0;
+}
+
+static void subtest_ws_iter_check_active_count(struct wakeup_source_iter *skel)
+{
+	static const char subtest_ws_name[] = "bpf_selftest_ws_active_count";
+	const int lock_unlock_cycles = 5;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	bool found_ws = false;
+	FILE *iter_file = NULL;
+	int iter_fd = -1;
+	int i;
+
+	for (i = 0; i < lock_unlock_cycles; i++) {
+		if (!ASSERT_OK(lock_ws(subtest_ws_name), "lock_ws"))
+			goto cleanup;
+		unlock_ws(subtest_ws_name);
+	}
+
+	if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, subtest_ws_name) == 0) {
+			found_ws = true;
+			ASSERT_EQ(ws_info.active_count, lock_unlock_cycles,
+				  "active_count check");
+			ASSERT_EQ(ws_info.wakeup_count, lock_unlock_cycles,
+				  "wakeup_count check");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_ws, "found active_count test ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_sleep_times(struct wakeup_source_iter *skel)
+{
+	bool found_test_ws = false;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	FILE *iter_file;
+	int iter_fd;
+
+	if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, test_ws_name) == 0) {
+			found_test_ws = true;
+			ASSERT_GT(ws_info.last_change_ms, 0,
+				  "Expected non-zero last change");
+			ASSERT_GE(ws_info.active_time_ms, TEST_SLEEP_MS,
+				  "Expected active time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.max_time_ms, TEST_SLEEP_MS,
+				  "Expected max time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.total_time_ms, TEST_SLEEP_MS,
+				  "Expected total time >= TEST_SLEEP_MS");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_test_ws, "found_test_ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_no_infinite_reads(
+		struct wakeup_source_iter *skel)
+{
+	int iter_fd;
+	char buf[256];
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(iter_fd, "iter_create"))
+		return;
+
+	while (read(iter_fd, buf, sizeof(buf)) > 0)
+		;
+
+	/* Final read should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	close(iter_fd);
+}
+
+void test_wakeup_source_iter(void)
+{
+	struct wakeup_source_iter *skel = NULL;
+
+	if (geteuid() != 0) {
+		fprintf(stderr,
+			"Skipping wakeup_source_iter test, requires root\n");
+		test__skip();
+		return;
+	}
+
+	skel = wakeup_source_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
+		goto destroy;
+
+	if (!ASSERT_OK(wakeup_source_iter__attach(skel), "skel_attach"))
+		goto destroy;
+
+	/*
+	 * Sleep on O(ms) to ensure that time stats' resolution isn't lost when
+	 * converting from ns to ms
+	 */
+	usleep(TEST_SLEEP_US);
+
+	if (test__start_subtest("active_count"))
+		subtest_ws_iter_check_active_count(skel);
+	if (test__start_subtest("sleep_times"))
+		subtest_ws_iter_check_sleep_times(skel);
+	if (test__start_subtest("no_infinite_reads"))
+		subtest_ws_iter_check_no_infinite_reads(skel);
+
+destroy:
+	teardown_test_ws();
+	wakeup_source_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
new file mode 100644
index 000000000000..9a377fd28f4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+#define NSEC_PER_MS 1000000UL
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/wakeup_source")
+int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
+{
+	const struct wakeup_source *ws = ctx->wakeup_source;
+	struct seq_file *seq = ctx->meta->seq;
+	char name[WAKEUP_SOURCE_NAME_LEN] = {'\0'};
+	const char *pname;
+	bool active, autosleep_enable;
+	u64 active_count, event_count, expire_count, wakeup_count;
+	s64 active_time, curr_time, last_change_time, max_time,
+	    prevent_sleep_time, start_prevent_time, total_time;
+
+	if (!ws)
+		return 0;
+
+	active = BPF_CORE_READ_BITFIELD_PROBED(ws, active);
+	autosleep_enable = BPF_CORE_READ_BITFIELD_PROBED(ws, autosleep_enabled);
+	if (bpf_core_read(&pname, sizeof(pname), &ws->name) ||
+	    bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0 ||
+	    bpf_core_read(&active_count, sizeof(active_count), &ws->active_count) ||
+	    bpf_core_read(&event_count, sizeof(event_count), &ws->event_count) ||
+	    bpf_core_read(&expire_count, sizeof(expire_count), &ws->expire_count) ||
+	    bpf_core_read(&last_change_time, sizeof(last_change_time), &ws->last_time) ||
+	    bpf_core_read(&max_time, sizeof(max_time), &ws->max_time) ||
+	    bpf_core_read(
+		&prevent_sleep_time, sizeof(prevent_sleep_time), &ws->prevent_sleep_time) ||
+	    bpf_core_read(
+		&start_prevent_time, sizeof(start_prevent_time), &ws->start_prevent_time) ||
+	    bpf_core_read(&total_time, sizeof(total_time), &ws->total_time) ||
+	    bpf_core_read(&wakeup_count, sizeof(wakeup_count), &ws->wakeup_count))
+		return 0;
+
+
+	curr_time = bpf_ktime_get_ns();
+	active_time = 0;
+	if (active) {
+		active_time = curr_time - last_change_time;
+		total_time += active_time;
+		if (active_time > max_time)
+			max_time = active_time;
+		if (autosleep_enable)
+			prevent_sleep_time += curr_time - start_prevent_time;
+
+	}
+
+	BPF_SEQ_PRINTF(seq,
+		       "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu\n",
+		       name,
+		       active_count,
+		       active_time / NSEC_PER_MS,
+		       event_count,
+		       expire_count,
+		       last_change_time / NSEC_PER_MS,
+		       max_time / NSEC_PER_MS,
+		       prevent_sleep_time / NSEC_PER_MS,
+		       total_time / NSEC_PER_MS,
+		       wakeup_count);
+	return 0;
+}
-- 
2.52.0.457.g6b5491de43-goog


