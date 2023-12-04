Return-Path: <linux-kselftest+bounces-1081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510B803EAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8C0281178
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 19:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8833078;
	Mon,  4 Dec 2023 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="nv/ue+Zw"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 11:47:03 PST
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67885E6
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 11:47:03 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com;
 q=dns/txt; s=mailo; t=1701719222; x=1701726422; h=Content-Transfer-Encoding:
 MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; bh=HmhFXlBPh7ZkC6JgQKrUP2LiSRCDQOnp19qvKKGJsfA=;
 b=nv/ue+Zw4OlbK2C+nT//hoL7vCp4EakTXQA9qLGBLlePslQc0KdhDiZfsJXclFBxWT8OH7N1Z6ZNEglsg/iJJqHGLYroOXy+qerhr0aTuprVdxN0AFPfDbmt+WMSybKkiAJrYK8JMnKA3dNCDq2V8VqyGuhirzcvGznFVLnRc34=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by fd7bfb80eee6 with SMTP id 656e2b88156c2f103906edef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Dec 2023 19:42:00 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-c45160e0-u25i.c.vimeo-core.internal [10.56.27.31])
	by smtp.vimeo.com (Postfix) with ESMTP id 55BD44DD;
	Mon,  4 Dec 2023 19:42:00 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 2E15AB422EE; Mon,  4 Dec 2023 14:42:00 -0500 (EST)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Finkel <davidf@vimeo.com>
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon,  4 Dec 2023 14:41:56 -0500
Message-Id: <20231204194156.2411672-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other mechanisms for querying the peak memory usage of either a process
or v1 memory cgroup allow for resetting the high watermark. Restore
parity with those mechanisms.

For example:
 - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
   the high watermark.
 - writing "5" to the clear_refs pseudo-file in a processes's proc
   directory resets the peak RSS.

This change copies the cgroup v1 behavior so any write to the
memory.peak and memory.swap.peak pseudo-files reset the high watermark
to the current usage.

This behavior is particularly useful for work scheduling systems that
need to track memory usage of worker processes/cgroups per-work-item.
Since memory can't be squeezed like CPU can (the OOM-killer has
opinions), these systems need to track the peak memory usage to compute
system/container fullness when binpacking workitems.

Signed-off-by: David Finkel <davidf@vimeo.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
 mm/memcontrol.c                               | 23 ++++++
 .../selftests/cgroup/test_memcontrol.c        | 72 ++++++++++++++++---
 3 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..95af0628dc44 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1305,11 +1305,13 @@ PAGE_SIZE multiple when read back.
 	reclaim induced by memory.reclaim.
 
   memory.peak
-	A read-only single value file which exists on non-root
-	cgroups.
+	A read-write single value file which exists on non-root cgroups.
+
+	The max memory usage recorded for the cgroup and its descendants since
+	either the creation of the cgroup or the most recent reset.
 
-	The max memory usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	Any non-empty write to this file resets it to the current memory usage.
+	All content written is completely ignored.
 
   memory.oom.group
 	A read-write single value file which exists on non-root
@@ -1626,11 +1628,13 @@ PAGE_SIZE multiple when read back.
 	Healthy workloads are not expected to reach this limit.
 
   memory.swap.peak
-	A read-only single value file which exists on non-root
-	cgroups.
+	A read-write single value file which exists on non-root cgroups.
+
+	The max swap usage recorded for the cgroup and its descendants since
+	the creation of the cgroup or the most recent reset.
 
-	The max swap usage recorded for the cgroup and its
-	descendants since the creation of the cgroup.
+	Any non-empty write to this file resets it to the current swap usage.
+	All content written is completely ignored.
 
   memory.swap.max
 	A read-write single value file which exists on non-root
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1c1061df9cd1..b04af158922d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/cgroup-defs.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -6635,6 +6636,16 @@ static u64 memory_peak_read(struct cgroup_subsys_state *css,
 	return (u64)memcg->memory.watermark * PAGE_SIZE;
 }
 
+static ssize_t memory_peak_write(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	page_counter_reset_watermark(&memcg->memory);
+
+	return nbytes;
+}
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -6947,6 +6958,7 @@ static struct cftype memory_files[] = {
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_peak_read,
+		.write = memory_peak_write,
 	},
 	{
 		.name = "min",
@@ -7917,6 +7929,16 @@ static u64 swap_peak_read(struct cgroup_subsys_state *css,
 	return (u64)memcg->swap.watermark * PAGE_SIZE;
 }
 
+static ssize_t swap_peak_write(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	page_counter_reset_watermark(&memcg->swap);
+
+	return nbytes;
+}
+
 static int swap_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -7999,6 +8021,7 @@ static struct cftype swap_files[] = {
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = swap_peak_read,
+		.write = swap_peak_write,
 	},
 	{
 		.name = "swap.events",
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c7c9572003a8..0326c317f1f2 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -161,12 +161,12 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
 /*
  * This test create a memory cgroup, allocates
  * some anonymous memory and some pagecache
- * and check memory.current and some memory.stat values.
+ * and checks memory.current, memory.peak, and some memory.stat values.
  */
-static int test_memcg_current(const char *root)
+static int test_memcg_current_peak(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long current;
+	long current, peak, peak_reset;
 	char *memcg;
 
 	memcg = cg_name(root, "memcg_test");
@@ -180,12 +180,32 @@ static int test_memcg_current(const char *root)
 	if (current != 0)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak != 0)
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_anon_50M_check, NULL))
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	peak_reset = cg_write(memcg, "memory.peak", "\n");
+	if (peak_reset != 0)
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak > MB(30))
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
@@ -815,13 +835,14 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
 /*
  * This test checks that memory.swap.max limits the amount of
- * anonymous memory which can be swapped out.
+ * anonymous memory which can be swapped out. Additionally, it verifies that
+ * memory.swap.peak reflects the high watermark and can be reset.
  */
-static int test_memcg_swap_max(const char *root)
+static int test_memcg_swap_max_peak(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *memcg;
-	long max;
+	long max, peak;
 
 	if (!is_swap_enabled())
 		return KSFT_SKIP;
@@ -838,6 +859,12 @@ static int test_memcg_swap_max(const char *root)
 		goto cleanup;
 	}
 
+	if (cg_read_long(memcg, "memory.swap.peak"))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak"))
+		goto cleanup;
+
 	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
 		goto cleanup;
 
@@ -860,6 +887,27 @@ static int test_memcg_swap_max(const char *root)
 	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.swap.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.peak", "\n"))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.peak") > MB(10))
+		goto cleanup;
+
+
+	if (cg_write(memcg, "memory.peak", "\n"))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak"))
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
 		goto cleanup;
 
@@ -867,6 +915,14 @@ static int test_memcg_swap_max(const char *root)
 	if (max <= 0)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.swap.peak");
+	if (peak < MB(19))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
@@ -1293,7 +1349,7 @@ struct memcg_test {
 	const char *name;
 } tests[] = {
 	T(test_memcg_subtree_control),
-	T(test_memcg_current),
+	T(test_memcg_current_peak),
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
@@ -1301,7 +1357,7 @@ struct memcg_test {
 	T(test_memcg_max),
 	T(test_memcg_reclaim),
 	T(test_memcg_oom_events),
-	T(test_memcg_swap_max),
+	T(test_memcg_swap_max_peak),
 	T(test_memcg_sock),
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
-- 
2.39.2


