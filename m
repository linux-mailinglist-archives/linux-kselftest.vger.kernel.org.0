Return-Path: <linux-kselftest+bounces-44377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F00C1E2D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCE3401B9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572C32D0EE;
	Thu, 30 Oct 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knymmcMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72D2522A7
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793231; cv=none; b=VsVtvPRZtA+dbm8XqeaO1+gCyVWtqTDwtEP59M5ZHHsVLXjzjCu+DJATENTrsMKOhy+7dvPbItrgl8+f2kzF0alLh6haJsXrJDdGYrc87pzN7OazwJGjP5TkT1D+6LLwzgqa73ZKK+i5vKLiRJz1taAjQdKvBxNPquIFX/UfqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793231; c=relaxed/simple;
	bh=p9VUFDUmElzhq3Y1NJOKencICnU7fgRdtPaIJ9+b4YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW6L2ajqDbr1ulBZGDtBTRR5gZd9R/odEHfqVnmCnftLyPKdG3sJWH0xZ7N1DRr8a5HELMNONxXmJfYLwdnnNjtqXAR6kT8eOqH9v82fZ6JG+FHd03HX/lyt6bttrhq6VGtPlXOJfMfBoISFQgaSIXJ9t6uT1LV/gnRcvUlRPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knymmcMW; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a28226dd13so550325b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793229; x=1762398029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOqMlrs96orUrV/G+q7YtbzEmic4V+UvSE86rYjh92Q=;
        b=knymmcMW1Ol7TBy/tegtY7HdPkZX/pSfd1XLnyoF/3qZGQKBXSNPwxck4ehfHAbkWI
         3H8aege1GhubMG01sRn5E24nPe7Izmgmu9QSInzfE54MxcbYPKeTnOAWau5FdA93PyjC
         Yj3vdhFM7BqiPJ7FCBQZbkDjq3nIBvMDghm4eP9qK+ocZlfQ8lzNZM4ziTWWAwZuBA/7
         TVY/lxVd6wGjQGshDfsRmBMhgcFlxSxrPyKgQTz9EqJIxJ3IaiCvzxLAwJBKsOVf8kU8
         zwOu/pqQT2awNd7ObW54KV2en/ZRQZltVJyHoFGob6afDy5iaDJ9oOB5E0grkUwByrgo
         VM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793229; x=1762398029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOqMlrs96orUrV/G+q7YtbzEmic4V+UvSE86rYjh92Q=;
        b=VyghxZxog2UwHrpVjuRW4zRe6GRdeFkK6C0d2QN80RVrDbZA0JvtN1Og/AQghgsYcB
         hTt9tGmTvhX+c6OC2/P5mgRnGtZNV2rk96aMIgTyFbQP+jKwqtqLI1BPmXv0Pt74QsCF
         0jBpI5tYjDPdv4i/1kM/0UXpXvhyGZOQ5zEQKg4+Vcwn1LbjoJBDMGyTRaya+AOOM/XD
         WfVtb25gMu51x5OYfNtXCy8332Q5DkH/TlxBAMHFy/jNbal/fEeJdPzQEPgOlgWOHqFW
         vf4RRxiMozArfXYxG8oYLLk3UKfuS41YmtJyJjpapgyUVQh8JnX5PeKwVL9kX1Z1Cthy
         JQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWlUBamkO1R6IVNJK5xWzUoISKn/GkEqRGvGQ4/Gw6qwsF7SfYlWQ2xSOGv4oCcirxgboXWaGB5ksrrMYpSoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJk66GEJQbIZX99pTcOmnKVX2/Xp13VxVXlA8RHvh9mQjwzEHz
	MMwBYzHidQFWVOMNfpXIE4I388vjEOQeLwv/+hyhY21A0XWwt8k0Unat
X-Gm-Gg: ASbGncss/OvA1yLe7TIMatjLIYonLWk+rdMuDf+8PxuMBp/sRdLAorS9jCfpgcbWg9l
	HntsMyWJCkRs29t6lRa9HJuv1fKpZ5WN/PztgCVoaixTIwXsSMXNdbUCWQ6txEouNd7/Ci2ZVbC
	PLwI0p6W6utMP/aywV4MFeQfGxon25X5V/q/aq/ppiNFO+PiitakZ/0k2sEJb8AsuH62QTuxhFq
	SK0UhGgM69Zq1K5bGeJVk1Uk976ZE+AvcXbwc0XHHalvos77TNmSbv55vPcwivO85ZxBvPhSHem
	9ukqDomf5y6XBwP8BRfS+KMRJPRDBSibWHddUdKDGy4f191Q2WL44MQoyFVHmGkJHGhZkcgeUC9
	6el31kiGShLJoV+jCdIVeYgTTM9xwolWgcj1/jQhCQzCgW7QEq8DjqocgSgwGrudd2Q/CqJDvO6
	Ia
X-Google-Smtp-Source: AGHT+IE+EkIZH7nXlS0M66HyWl57U57NNIvburFNgkiF/aZKFtLI6PX9C71beMO3KKsYSq3AkXoUuA==
X-Received: by 2002:a05:6a00:806:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a624c63426mr1985029b3a.13.1761793228514;
        Wed, 29 Oct 2025 20:00:28 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:28 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test map deadlock caused by NMI
Date: Thu, 30 Oct 2025 11:00:10 +0800
Message-ID: <20251030030010.95352-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251030030010.95352-1-dongml2@chinatelecom.cn>
References: <20251030030010.95352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this testing, map updating and deleting both happen in NMI context and
user context, which is used to detect the possible deadlock.

For now, LRU is added in the testing, and more map type can be added in
the feature.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/map_deadlock.c   | 136 ++++++++++++++++++
 .../selftests/bpf/progs/map_deadlock.c        |  52 +++++++
 2 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_deadlock.c b/tools/testing/selftests/bpf/prog_tests/map_deadlock.c
new file mode 100644
index 000000000000..17fcf1f5efa6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_deadlock.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <pthread.h>
+#include "map_deadlock.skel.h"
+
+
+static int perf_open_all_cpus(struct perf_event_attr *attr, int fds[], int max_cpus)
+{
+	int n = 0;
+
+	for (int cpu = 0; cpu < max_cpus; cpu++) {
+		int fd = syscall(__NR_perf_event_open, attr, -1 /* pid: all */, cpu,
+				 -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+		if (fd < 0)
+			continue;
+		fds[cpu] = fd;
+		n++;
+	}
+	return n;
+}
+
+struct thread_arg {
+	int map_fd;
+	bool *stop;
+};
+
+static void *user_update_thread(void *argp)
+{
+	struct thread_arg *arg = argp;
+	u32 key = 0;
+	u64 val = 1;
+
+	while (!*arg->stop) {
+		key++;
+		val++;
+		bpf_map_update_elem(arg->map_fd, &key, &val, BPF_ANY);
+		if ((key & 0x7) == 0)
+			bpf_map_delete_elem(arg->map_fd, &key);
+	}
+	return NULL;
+}
+
+static void test_map(const char *map_name, int map_index)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.size = sizeof(struct perf_event_attr),
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.sample_period = 1000000,
+		.freq = 0,
+		.disabled = 0,
+		.wakeup_events = 1,
+	};
+	int map_fd, nfd = 0, max_cpus, err;
+	struct bpf_link **links = NULL;
+	struct map_deadlock *skel;
+	struct bpf_program *prog;
+	struct thread_arg targ;
+	bool stop = false;
+	int *fds = NULL;
+	pthread_t thr;
+
+	skel = map_deadlock__open();
+	if (!ASSERT_OK_PTR(skel, "map_deadlock__open"))
+		return;
+	skel->rodata->map_index = map_index;
+	err = map_deadlock__load(skel);
+	if (!ASSERT_OK(err, "map_deadlock__load"))
+		goto out;
+
+	prog = skel->progs.on_perf;
+	map_fd = bpf_object__find_map_fd_by_name(skel->obj, map_name);
+	if (!ASSERT_GE(map_fd, 0, map_name))
+		goto out;
+
+	max_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(max_cpus, 0, "num cpus"))
+		goto out;
+
+	links = calloc(max_cpus, sizeof(*links));
+	ASSERT_OK_PTR(links, "alloc links");
+	fds = calloc(max_cpus, sizeof(*fds));
+	ASSERT_OK_PTR(fds, "alloc fds");
+	for (int i = 0; i < max_cpus; i++)
+		fds[i] = -1;
+
+	nfd = perf_open_all_cpus(&attr, fds, max_cpus);
+	if (!ASSERT_GT(nfd, 0, "perf fds"))
+		goto out;
+
+	for (int cpu = 0; cpu < max_cpus; cpu++) {
+		if (fds[cpu] < 0)
+			continue;
+		links[cpu] = bpf_program__attach_perf_event(prog, fds[cpu]);
+		if (!ASSERT_OK_PTR(links[cpu], "attach perf"))
+			goto out;
+	}
+
+	targ.map_fd = map_fd;
+	targ.stop = &stop;
+	err = pthread_create(&thr, NULL, user_update_thread, &targ);
+	if (!ASSERT_OK(err, "create thr"))
+		goto out;
+
+	/* 1 second should be enough to trigger the deadlock */
+	sleep(1);
+	stop = true;
+	(void)pthread_join(thr, NULL);
+	/* TODO: read dmesg to check the deadlock? */
+out:
+	if (links) {
+		for (int cpu = 0; cpu < max_cpus; cpu++) {
+			if (links[cpu])
+				bpf_link__destroy(links[cpu]);
+		}
+	}
+	if (fds) {
+		for (int cpu = 0; cpu < max_cpus; cpu++) {
+			if (fds[cpu] >= 0)
+				close(fds[cpu]);
+		}
+	}
+	free(links);
+	free(fds);
+	map_deadlock__destroy(skel);
+}
+
+void test_map_deadlock(void)
+{
+	if (test__start_subtest("lru"))
+		test_map("lru_map", 0);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_deadlock.c b/tools/testing/selftests/bpf/progs/map_deadlock.c
new file mode 100644
index 000000000000..6966224955fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_deadlock.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct lru_map {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1024);
+	__type(key, u32);
+	__type(value, u64);
+} lru_map SEC(".maps");
+
+struct map_list {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__array(values, struct lru_map);
+} map_list SEC(".maps") = {
+	.values = { [0] = &lru_map },
+};
+
+const volatile int map_index;
+
+static __always_inline void do_update_delete(void *map)
+{
+	u64 ts = bpf_ktime_get_ns();
+	u32 key = (u32)(ts >> 12);
+	u64 val = ts;
+
+	if ((ts & 1) == 0)
+		bpf_map_update_elem(map, &key, &val, BPF_ANY);
+	else
+		bpf_map_delete_elem(map, &key);
+}
+
+SEC("perf_event")
+int on_perf(struct bpf_perf_event_data *ctx)
+{
+	int key = map_index;
+	void *target_map;
+
+	target_map = bpf_map_lookup_elem(&map_list, &key);
+	if (!target_map)
+		return 0;
+
+	for (int i = 0; i < 4; i++)
+		do_update_delete(target_map);
+	return 0;
+}
-- 
2.51.2


