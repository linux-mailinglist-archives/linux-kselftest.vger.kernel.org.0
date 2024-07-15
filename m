Return-Path: <linux-kselftest+bounces-13754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D9931C0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE04283266
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2313AD33;
	Mon, 15 Jul 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="Nn/mhU7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BA2B9CD
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075925; cv=none; b=il+TqnaV0qBUFHCvUdFW9BI3sZVS5fQUZNMK9iPon4otVA7xXnvpgRN8lYr30GkXVl2d28l3Oo6PNoftaVtQs3uW7V3jJDET/qiczRfUoNS6XQ6O7mvliUSJD+E+izoSS9W303FRi/aR7mO4GBjBdBkChQjJescJMEkru6xbO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075925; c=relaxed/simple;
	bh=+Xtgd6gTiGapofcp6an2Gfe8xZh8+ytmFkpGq6TdCeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O40cbex2ZwhDbf7QL33uqwV07+3tmY9rKWq+n7YXDmiat8d1IF0z2LP359+CiPON8iBXoiKgM7IwrfPcBUtkZ/tCVIv5xHWsqSn3d49eZk/wUrhwO9qBvcVYEgQskgbzgk7UQjK57ebfP4I9aso+LbY73OzjtoHbrTHU/K/nFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=Nn/mhU7D; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721075923; x=1721083123;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=HfRPdAcnrMbjlOo0wWrv74jdg37Jc0Mwt1QOfTOfj30=;
 b=Nn/mhU7Dxi9ZNj1vv1jW1lps8t1MegObvKKd9vcVBWXQ7V1LwAynorXUFGyvh3aIzuXov0WyQjZ3wMplv+j4qhOpxJqyQNoC7AK0prgDhmEEkdzLtLXWW9Tgu7E8mfvjzeUs/1CPXdVyifxG49/0+dQw5swJDnPtlPXbTvUZsj8=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 5c992e5e8abf with SMTP id 669588d2a9a2764e22567f23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jul 2024 20:38:42 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-7f6ba6de-c8sv.c.vimeo-core.internal [10.56.27.202])
	by smtp.vimeo.com (Postfix) with ESMTP id BA2266011D;
	Mon, 15 Jul 2024 20:38:42 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 96787B408B8; Mon, 15 Jul 2024 16:38:42 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Finkel <davidf@vimeo.com>
Subject: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 15 Jul 2024 16:36:26 -0400
Message-Id: <20240715203625.1462309-2-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715203625.1462309-1-davidf@vimeo.com>
References: <20240715203625.1462309-1-davidf@vimeo.com>
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
index 8fbb0519d556..201d8e5d9f82 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1322,11 +1322,13 @@ PAGE_SIZE multiple when read back.
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
@@ -1652,11 +1654,13 @@ PAGE_SIZE multiple when read back.
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
index 8f2f1bb18c9c..abfa547615d6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -25,6 +25,7 @@
  * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */
 
+#include <linux/cgroup-defs.h>
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
@@ -6915,6 +6916,16 @@ static u64 memory_peak_read(struct cgroup_subsys_state *css,
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
@@ -7232,6 +7243,7 @@ static struct cftype memory_files[] = {
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_peak_read,
+		.write = memory_peak_write,
 	},
 	{
 		.name = "min",
@@ -8201,6 +8213,16 @@ static u64 swap_peak_read(struct cgroup_subsys_state *css,
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
@@ -8283,6 +8305,7 @@ static struct cftype swap_files[] = {
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = swap_peak_read,
+		.write = swap_peak_write,
 	},
 	{
 		.name = "swap.events",
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b889..681972de673b 100644
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
@@ -817,13 +837,14 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
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
@@ -840,6 +861,12 @@ static int test_memcg_swap_max(const char *root)
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
 
@@ -862,6 +889,27 @@ static int test_memcg_swap_max(const char *root)
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
 
@@ -869,6 +917,14 @@ static int test_memcg_swap_max(const char *root)
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
@@ -1295,7 +1351,7 @@ struct memcg_test {
 	const char *name;
 } tests[] = {
 	T(test_memcg_subtree_control),
-	T(test_memcg_current),
+	T(test_memcg_current_peak),
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
@@ -1303,7 +1359,7 @@ struct memcg_test {
 	T(test_memcg_max),
 	T(test_memcg_reclaim),
 	T(test_memcg_oom_events),
-	T(test_memcg_swap_max),
+	T(test_memcg_swap_max_peak),
 	T(test_memcg_sock),
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
-- 
2.40.1


