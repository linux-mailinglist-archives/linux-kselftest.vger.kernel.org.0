Return-Path: <linux-kselftest+bounces-48002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE3CE89D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 04:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45313011A68
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1492E3AF1;
	Tue, 30 Dec 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+ZuAw+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC51226D1E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767063801; cv=none; b=e1YHm/BezN0al3FSoClf9QjoXeF2Ew8SLtFGMWF/NB5BJb8IOSVbMpPGUr6Q1ROxTfmMjEhVdGxpVke+p4eD8WmxJBOtZwoyA6+puZBMPYgAuxGX0JjgLut+N2+/UUYxfsEZJBCjUBpLuVqgwyvvbBhl4UZkQar1RBo/YQOeIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767063801; c=relaxed/simple;
	bh=6UycAJ2yAhnqVEWA8s22t5gAGc140ycPNUY2cmccNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZC37xZuFAcvAUgXwhJSvWfv2uaZuO11xwnmYpoCp3wU97TalcFghmqaPNQa8LiqLS4paHPjTP4vzDN4njCX/DfH8HGzvyCARG7fyNQm+7n9d3Zu9b/aF+icnv9OAfmTwrAm98/Xu5IYEI6OXByerbuLv+kQ6RTcK6+mVXstCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+ZuAw+l; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767063797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8//Oi2G1pKnFUghKjsfRIoxmjU4PeKel12hQ84aiqSs=;
	b=r+ZuAw+lhSAHBhrXrVpbEG2Su1ZIU1A16DBytctzR6qMVN7LNzTxiuMj1kipZ5WgM4pRx4
	a280Pp2UvwK7Sv7cud2ivCUt7PKSBz4LmjJE+JNvndS29yfgL20U0dC4sO2NnNli9aV0aq
	PgPGBB/K8DrIm7SPRsACohj81YgBxb8=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH v2 2/3] selftests/bpf: Add tests for memcg_bpf_ops
Date: Tue, 30 Dec 2025 11:02:00 +0800
Message-ID: <7a5d695fdccb66fbe6511f3b10f8b1d06713e604.1767012332.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1767012332.git.zhuhui@kylinos.cn>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add comprehensive selftests for the memcg_bpf_ops struct_ops
functionality.

The test creates a cgroup hierarchy with high and low priority
cgroups, attaches a BPF program that monitors PGSCAN events on
the high-priority cgroup, and verifies that low-priority tasks
are throttled when the BPF program reports additional overage.

Test flow:
1. Create /memcg_ops_test/high and /memcg_ops_test/low cgroups
2. Attach BPF program to monitor high cgroup's PGSCAN events
3. When PGSCAN events exceed threshold (64 pages/sec), report
   512 pages over high for low cgroup
4. Run memory-intensive workloads in both cgroups
5. Verify low-priority workload is significantly slower

The BPF program uses:
- Tracepoint to monitor memcg:count_memcg_events
- One-second sliding window for PGSCAN aggregation
- Trigger mechanism with configurable threshold and overage

This validates that:
- BPF programs can be attached to cgroup hierarchies
- memcg_nr_pages_over_high hook is called correctly
- Memory pressure calculation includes BPF-reported overage
- Throttling behavior works as expected

This test does not use PSI for triggering due to the
reasons discussed in:
https://lore.kernel.org/lkml/1d9a162605a3f32ac215430131f7745488deaa34@linux.dev/

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                                   |   2 +
 .../selftests/bpf/prog_tests/memcg_ops.c      | 340 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_ops_over_high.c |  95 +++++
 3 files changed, 437 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops_over_high.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 158f3ba63ee7..10508c90136a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6356,6 +6356,8 @@ F:	mm/memcontrol-v1.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
+F:	tools/testing/selftests/bpf/prog_tests/memcg_ops.c
+F:	tools/testing/selftests/bpf/progs/memcg_ops_over_high.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
new file mode 100644
index 000000000000..48f0ca4a032b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory controller eBPF struct ops test
+ */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cgroup_helpers.h"
+
+struct local_config {
+	u64 threshold;
+	u64 high_cgroup_id;
+	unsigned int over_high;
+} local_config;
+
+#include "memcg_ops_over_high.skel.h"
+
+#define OVER_HIGH_THRESHOLD 64
+#define OVER_HIGH_NUM 512
+#define FILE_SIZE (512 * 1024 * 1024ul)
+#define BUFFER_SIZE (128 * 1024)
+#define READ_ITERATIONS 5
+#define CG_LIMIT (512 * 1024 * 1024ul)
+
+#define CG_DIR "/memcg_ops_test"
+#define CG_HIGH_DIR CG_DIR "/high"
+#define CG_LOW_DIR CG_DIR "/low"
+
+
+static int setup_cgroup(int *high_cgroup_id, int *low_cgroup_fd)
+{
+	int ret;
+	char limit_buf[20];
+
+	ret = setup_cgroup_environment();
+	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
+		goto cleanup;
+
+	ret = create_and_get_cgroup(CG_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_DIR))
+		goto cleanup;
+	close(ret);
+	ret = enable_controllers(CG_DIR, "memory");
+	if (!ASSERT_OK(ret, "enable_controllers"))
+		goto cleanup;
+	snprintf(limit_buf, 20, "%ld", CG_LIMIT);
+	ret = write_cgroup_file(CG_DIR, "memory.max", limit_buf);
+	if (!ASSERT_OK(ret, "write_cgroup_file"))
+		goto cleanup;
+
+	ret = create_and_get_cgroup(CG_HIGH_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_HIGH_DIR))
+		goto cleanup;
+	close(ret);
+	ret = (int)get_cgroup_id(CG_HIGH_DIR);
+	if (!ASSERT_GE(ret, 0, "get_cgroup_id"))
+		goto cleanup;
+	*high_cgroup_id = ret;
+
+	ret = create_and_get_cgroup(CG_LOW_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_LOW_DIR))
+		goto cleanup;
+	*low_cgroup_fd = ret;
+
+	return 0;
+
+cleanup:
+	cleanup_cgroup_environment();
+	return -1;
+}
+
+int write_file(const char *filename)
+{
+	int ret = -1;
+	size_t written = 0;
+	char *buffer;
+	FILE *fp;
+
+	fp = fopen(filename, "wb");
+	if (!fp)
+		goto out;
+
+	buffer = malloc(BUFFER_SIZE);
+	if (!buffer)
+		goto cleanup_fp;
+
+	memset(buffer, 'A', BUFFER_SIZE);
+
+	while (written < FILE_SIZE) {
+		size_t to_write = (FILE_SIZE - written < BUFFER_SIZE) ?
+				   (FILE_SIZE - written) :
+				   BUFFER_SIZE;
+
+		if (fwrite(buffer, 1, to_write, fp) != to_write)
+			goto cleanup;
+		written += to_write;
+	}
+
+	ret = 0;
+cleanup:
+	free(buffer);
+cleanup_fp:
+	fclose(fp);
+out:
+	return ret;
+}
+
+int read_file(const char *filename, int iterations)
+{
+	int ret = -1;
+	char *buffer;
+
+	buffer = malloc(BUFFER_SIZE);
+	if (!buffer)
+		goto out;
+
+	for (int iter = 0; iter < iterations; iter++) {
+		FILE *fp = fopen(filename, "rb");
+
+		if (!fp)
+			goto cleanup;
+
+		size_t total_read = 0;
+		size_t bytes_read;
+
+		while ((bytes_read = fread(buffer, 1, BUFFER_SIZE, fp)) > 0)
+			total_read += bytes_read;
+
+		fclose(fp);
+
+		if (env.verbosity >= VERBOSE_NORMAL)
+			printf("%s %d %d done\n",
+				__func__, getpid(), iter);
+	}
+
+	ret = 0;
+cleanup:
+	free(buffer);
+out:
+	return ret;
+}
+
+static void real_test_memcg_ops_over_high_child_work(const char *cgroup_path,
+						     char *data_filename,
+						     char *time_filename)
+{
+	struct timeval start, end;
+	double elapsed;
+	FILE *fp;
+
+	if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgroup"))
+		goto out;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d begin\n", __func__, getpid());
+
+	gettimeofday(&start, NULL);
+
+	if (!ASSERT_OK(write_file(data_filename), "write_file"))
+		goto out;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d write_file done\n", __func__, getpid());
+
+	if (!ASSERT_OK(read_file(data_filename, READ_ITERATIONS), "read_file"))
+		goto out;
+
+	gettimeofday(&end, NULL);
+
+	elapsed = (end.tv_sec - start.tv_sec) +
+		  (end.tv_usec - start.tv_usec) / 1000000.0;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d end %.6f\n", __func__, getpid(), elapsed);
+
+	fp = fopen(time_filename, "w");
+	if (!ASSERT_OK_PTR(fp, "fopen"))
+		goto out;
+	fprintf(fp, "%.6f", elapsed);
+	fclose(fp);
+
+out:
+	exit(0);
+}
+
+static int get_time(char *time_filename, double *time)
+{
+	int ret = -1;
+	FILE *fp;
+
+	fp = fopen(time_filename, "r");
+	if (!fp)
+		goto out;
+
+	if (fscanf(fp, "%lf", time) < 0)
+		goto cleanup;
+
+	ret = 0;
+cleanup:
+	fclose(fp);
+out:
+	return ret;
+}
+
+static void real_test_memcg_ops_over_high(void)
+{
+	int ret;
+	char data_file1[] = "/tmp/test_data_XXXXXX";
+	char data_file2[] = "/tmp/test_data_XXXXXX";
+	char time_file1[] = "/tmp/test_time_XXXXXX";
+	char time_file2[] = "/tmp/test_time_XXXXXX";
+	pid_t pid1, pid2;
+	double time1, time2;
+
+	ret = mkstemp(data_file1);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		return;
+	close(ret);
+	ret = mkstemp(data_file2);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_data_file1;
+	close(ret);
+	ret = mkstemp(time_file1);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_data_file2;
+	close(ret);
+	ret = mkstemp(time_file2);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_time_file1;
+	close(ret);
+
+	pid1 = fork();
+	if (!ASSERT_GE(pid1, 0, "fork"))
+		goto cleanup;
+	if (pid1 == 0)
+		real_test_memcg_ops_over_high_child_work(CG_LOW_DIR,
+							 data_file1,
+							 time_file1);
+
+	pid2 = fork();
+	if (!ASSERT_GE(pid1, 0, "fork"))
+		goto cleanup;
+	if (pid2 == 0)
+		real_test_memcg_ops_over_high_child_work(CG_HIGH_DIR,
+							 data_file2,
+							 time_file2);
+
+	ret = waitpid(pid1, NULL, 0);
+	if (!ASSERT_GT(ret, 0, "waitpid"))
+		goto cleanup;
+
+	ret = waitpid(pid2, NULL, 0);
+	if (!ASSERT_GT(ret, 0, "waitpid"))
+		goto cleanup;
+
+	if (CHECK_FAIL(get_time(time_file1, &time1)))
+		goto cleanup;
+
+	if (CHECK_FAIL(get_time(time_file2, &time2)))
+		goto cleanup;
+
+	ASSERT_TRUE(time1 > time2 && time1 - time2 > 1,
+		    "low fast compare");
+
+cleanup:
+	unlink(time_file2);
+cleanup_time_file1:
+	unlink(time_file1);
+cleanup_data_file2:
+	unlink(data_file2);
+cleanup_data_file1:
+	unlink(data_file1);
+}
+
+void test_memcg_ops_over_high(void)
+{
+	int err, map_fd;
+	struct memcg_ops_over_high *skel;
+	struct bpf_map *map;
+	size_t bss_sz;
+	struct memcg_ops_over_high__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link2 = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	int high_cgroup_id, low_cgroup_fd;
+
+	err = setup_cgroup(&high_cgroup_id, &low_cgroup_fd);
+	if (!ASSERT_OK(err, "setup_cgroup"))
+		goto out;
+
+	skel = memcg_ops_over_high__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_ops_over_high__open_and_load"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name .bss"))
+		goto out;
+
+	map_fd = bpf_map__fd(map);
+	bss_sz = bpf_map__value_size(map);
+	bss_data = malloc(bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "malloc(bpf_map__value_size(map))"))
+		goto out;
+	memset(bss_data, 0, sizeof(struct local_config));
+	bss_data->local_config.high_cgroup_id = high_cgroup_id;
+	bss_data->local_config.threshold = OVER_HIGH_THRESHOLD;
+	bss_data->local_config.over_high = OVER_HIGH_NUM;
+	err = bpf_map_update_elem(map_fd, &key, bss_data, BPF_EXIST);
+	free(bss_data);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel->obj,
+						"handle_count_memcg_events");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "mcg_ops");
+	if (!ASSERT_OK_PTR(link, "bpf_object__find_map_by_name mcg_ops"))
+		goto out;
+
+	opts.relative_fd = low_cgroup_fd;
+	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	real_test_memcg_ops_over_high();
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link2);
+	memcg_ops_over_high__detach(skel);
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_ops_over_high.c b/tools/testing/selftests/bpf/progs/memcg_ops_over_high.c
new file mode 100644
index 000000000000..5c9651ec96d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_ops_over_high.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define ONE_SECOND_NS	1000000000
+
+struct local_config {
+	u64 threshold;
+	u64 high_cgroup_id;
+	unsigned int over_high;
+} local_config;
+
+struct AggregationData {
+	u64 sum;
+	u64 window_start_ts;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct AggregationData);
+} aggregation_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} trigger_ts_map SEC(".maps");
+
+SEC("tp/memcg/count_memcg_events")
+int
+handle_count_memcg_events(struct trace_event_raw_memcg_rstat_events *ctx)
+{
+	u32 key = 0;
+	struct AggregationData *data;
+	u64 current_ts;
+
+	if (ctx->id != local_config.high_cgroup_id ||
+	    (ctx->item != PGSCAN_KSWAPD && ctx->item != PGSCAN_DIRECT))
+		goto out;
+
+	data = bpf_map_lookup_elem(&aggregation_map, &key);
+	if (!data)
+		goto out;
+
+	current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - data->window_start_ts < ONE_SECOND_NS) {
+		data->sum += ctx->val;
+	} else {
+		data->window_start_ts = current_ts;
+		data->sum = ctx->val;
+	}
+
+	if (data->sum > local_config.threshold) {
+		bpf_map_update_elem(&trigger_ts_map, &key, &current_ts,
+				    BPF_ANY);
+		data->sum = 0;
+		data->window_start_ts = current_ts;
+	}
+
+out:
+	return 0;
+}
+
+SEC("struct_ops/memcg_nr_pages_over_high")
+unsigned int memcg_nr_pages_over_high_impl(struct mem_cgroup *memcg)
+{
+	u32 key = 0;
+	u64 *trigger_ts;
+	unsigned int ret = 0;
+
+	trigger_ts = bpf_map_lookup_elem(&trigger_ts_map, &key);
+	if (!trigger_ts || *trigger_ts == 0)
+		goto out;
+
+	u64 current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - *trigger_ts < ONE_SECOND_NS)
+		ret = local_config.over_high;
+
+out:
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops mcg_ops = {
+	.memcg_nr_pages_over_high = (void *)memcg_nr_pages_over_high_impl,
+};
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


