Return-Path: <linux-kselftest+bounces-46969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B452CA23DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1FBF3067D2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 03:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AAF31986C;
	Thu,  4 Dec 2025 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jubUj/ax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D98305E33
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816642; cv=none; b=P8wasMWXnQgYfR6E6GWrCi9MO7qKDeZRl66Uk6Z1Xahrw6ZWMzt4etOQDki8OKTUDA5iE50VplDSkv7RY6m2tpdrBlM4IelqB7PIEEZZaEYx/l2I8uWNGsd5480IWlOhzt74cZn7XcmetQVXsIYZxGQWBMn9ZYVLisatfMgPNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816642; c=relaxed/simple;
	bh=Sxb2CNnwB5yz3Nvjw4v4DZy/DWUkxcLvLfxMRg2Odl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=se11uA3jt4qVKF9WdZFoAHxVN7q+S27h2zfbZOdjxfxtav32b++nYBZgy2Fci/igPDe11RS5CEe/reA73/k+FbIYMGHvQ0DNbwrGQjxzj9olrKrvyTfSd4ZgC8Nt3MqMTu9RNwh1/kRa21j4YAi+4pi5FacfyxiZdRCV1+trWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jubUj/ax; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b993eb2701bso415494a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 18:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764816626; x=1765421426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+aQqCsw+NRuorfpf97PO+5v01PI5CSW8XqAEaIZiTg=;
        b=jubUj/axkNXpyvKN3Rkl8MIG339rmQmUt/bMdilIPPlZ+hxSeU6ZkCei3heXa5Nqe7
         xwvzRTyiEV99CAdYRbOY2VwbLixFNPMSaCgO2L2v5LrwA/NH79kavKAWoSDcFTr9uCsV
         /+9hlCayGPQNtj9amI09Yfef0z9R1gWpgAgKyHu5HkboRNAWVSi3SMkhlbUPf1ahNzY2
         tZPRgsb4N9OmY70g668CM0drHzf4eR9nq9fJsIGXwT+jfW71GcedOERcZGGpWOW/SFfE
         kPT/IzvKwva27GFxw42AL6ABWg0NTV4wuTxUo897ZWiIjqlOHirQ9gIuGiM6Ck8+yl1F
         //ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816626; x=1765421426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+aQqCsw+NRuorfpf97PO+5v01PI5CSW8XqAEaIZiTg=;
        b=Si34QVl0NHpLpLhfLDf8xunndE0KFPU+Xve5DYFKmac9L80Rd8+HgyDIC7W193jEoG
         7WEf10dUF853lbTRsS1iJeYejOVVwBkPzCBMu9IR3Gu/yJeaOTKEH5BG1L+Ys6e4Qo69
         nnXsLiiI/+76CmaKBLKXRT8hJbc/GOifBLZTV6A0y0eUJTCsXv2asp/xFQVDAon4y6hg
         pU8QczijHap7kxymeuhNvK4UW2JKCT0aadcUKAk86JX7ig7iiDtC+hLTtvbFfcvYeA6q
         mhjjHDQUreUYNoN2jjEYErRIilLjZPcEcERmkanykvaKWXbuC1yv/o9Cxba2xXs1LVg1
         99Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVcculyHmoLkyqBhJscRAU7aZNcPSU/PitAJjmt+MJpIfY3iSSz/iRSjU9fh9c5wG4A9U0XUVhRGYg8LVJV/6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ePvGIpFf1Wbyl+8qC385Rxz22gSS/791lZegGNxU8AJPAo99
	aOmc7o5u9xBApdhG9D9Etr+TCNQb9qjftM+LIUfKpCfjhnf26OK4QSuJp0HCQtG0WdAOdyb8M4x
	UPJU7GX+TQTaJvA==
X-Google-Smtp-Source: AGHT+IGVVV3e4uaKvdPuVO3KdHUpfuc4ovAm0F/av9uVP3ephWBMsJRols3ojDvenOv6Fn8IlvZue3yTqL3Asw==
X-Received: from dlyy13.prod.google.com ([2002:a05:7022:68d:b0:11b:a3a4:c8b9])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:fa3:b0:119:e56b:98b8 with SMTP id a92af1059eb24-11df649e57cmr1046177c88.31.1764816626176;
 Wed, 03 Dec 2025 18:50:26 -0800 (PST)
Date: Wed,  3 Dec 2025 18:50:00 -0800
In-Reply-To: <20251204025003.3162056-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204025003.3162056-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204025003.3162056-4-wusamuel@google.com>
Subject: [PATCH v1 3/4] selftests/bpf: Add tests for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: rafael.j.wysocki@intel.com, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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
index 000000000000..5cea4d4458f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google LLC */
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
index 000000000000..8c1470f06740
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google LLC */
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
2.52.0.177.g9f829587af-goog


