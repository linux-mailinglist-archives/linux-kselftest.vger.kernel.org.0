Return-Path: <linux-kselftest+bounces-14122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54D93A9E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172101F2345E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B91494B3;
	Tue, 23 Jul 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="lWbnB1Pr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA8145B0D
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777524; cv=none; b=KnwXxi56uvv6avnb3gdm+PJmuw9SEu8zEvvQI20eCLZHH212gNITXMHBOWi0YZYts2eCp2pzcRpw2XcCT2T7Tx8iBXOmuGzFpl08f8h1c12MdhUfoND3utjsF5NHTqR7mSV+RS8TXvLtquQ6JK6fy+uCd4EsRCf7CaZ6gnl0TOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777524; c=relaxed/simple;
	bh=PUcsM/fIEpCBs64C6OM9dall8whx4qUci7W0ucIt04Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEsP99B2DBpd0A51m2U7eG0Ou1yGc2/xzhjJt4HU0NnEoI7pmtKua+dmrMVn5Ge6luK+bmtyGJgmPin7D4C6a2bxZEg5U31to5We0M+KQVzNOUq8a6H5cbpGaarEhCcHeIeowZ2W/Vs3BCWhCa5Eu1vGq5/SE6d/XXvKOvN7T8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=lWbnB1Pr; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721777522; x=1721784722;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=t2iHNmDNFh2Lhloylho+v4Z/hy/KUWvSDvmAzMoAG5g=;
 b=lWbnB1PrBinb3d0n/kkWO81D7lqKbSXoJ6L1wulURYA7PnHuQPBEI0pjEegpFpNA9rTAniSPqtZLgk93Qb5Fetj/yCQhltU/liMMGwNZPQ2Hf4p4EKX89RA3qn8KColnAnxR4lNS87O0iKfrW8YKvy8B23RTLv/KvHhzix3deWI=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 9ee007f60f00 with SMTP id 66a03d72cb8a873c2ea87613 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jul 2024 23:32:02 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-7f6ba6de-bm2w.c.vimeo-core.internal [10.56.27.208])
	by smtp.vimeo.com (Postfix) with ESMTP id 6065164D5F;
	Tue, 23 Jul 2024 23:32:02 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 40707B4133E; Tue, 23 Jul 2024 19:32:02 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Finkel <davidf@vimeo.com>
Subject: [PATCH 2/2] mm, memcg: cg2 memory{.swap,}.peak write tests
Date: Tue, 23 Jul 2024 19:31:49 -0400
Message-Id: <20240723233149.3226636-3-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240723233149.3226636-1-davidf@vimeo.com>
References: <20240723233149.3226636-1-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend two existing tests to cover extracting memory usage through the
newly mutable memory.peak and memory.swap.peak handlers.

In particular, make sure to exercise adding and removing watchers with
overlapping lifetimes so the less-trivial logic gets tested.

Signed-off-by: David Finkel <davidf@vimeo.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c  |  22 ++
 tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
 .../selftests/cgroup/test_memcontrol.c        | 226 +++++++++++++++++-
 3 files changed, 242 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 432db923bced0..1e2d46636a0ca 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -141,6 +141,16 @@ long cg_read_long(const char *cgroup, const char *control)
 	return atol(buf);
 }
 
+long cg_read_long_fd(int fd)
+{
+	char buf[128];
+
+	if (pread(fd, buf, sizeof(buf), 0) <= 0)
+		return -1;
+
+	return atol(buf);
+}
+
 long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 {
 	char buf[PAGE_SIZE];
@@ -183,6 +193,18 @@ int cg_write(const char *cgroup, const char *control, char *buf)
 	return ret == len ? 0 : ret;
 }
 
+/*
+ * Returns fd on success, or -1 on failure.
+ * (fd should be closed with close() as usual)
+ */
+int cg_open(const char *cgroup, const char *control, int flags)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+	return open(path, flags);
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index e8d04ac9e3d23..19b131ee77072 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -34,9 +34,11 @@ extern int cg_read_strcmp(const char *cgroup, const char *control,
 extern int cg_read_strstr(const char *cgroup, const char *control,
 			  const char *needle);
 extern long cg_read_long(const char *cgroup, const char *control);
+extern long cg_read_long_fd(int fd);
 long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
+extern int cg_open(const char *cgroup, const char *control, int flags);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b8895..30730a3c26412 100644
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
@@ -180,15 +180,108 @@ static int test_memcg_current(const char *root)
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
+	/*
+	 * We'll open a few FDs for the same memory.peak file to exercise the free-path
+	 * We need at least three to be closed in a different order than writes occurred to test
+	 * the linked-list handling.
+	 */
+	int peak_fd = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd == -1)
+		goto cleanup;
+
+	bool fd2_closed = false, fd3_closed = false, fd4_closed = false;
+	int peak_fd2 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd2 == -1)
+		goto cleanup;
+
+	int peak_fd3 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd3 == -1)
+		goto cleanup;
+
+	static const char reset_string[] = "reset\n";
+
+	peak_reset = write(peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(peak_fd2, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(peak_fd3, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	/* Make sure a completely independent read isn't affected by our  FD-local reset above*/
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	fd2_closed = true;
+	if (close(peak_fd2))
+		goto cleanup;
+
+	int peak_fd4 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd4 == -1)
+		goto cleanup;
+
+	peak_reset = write(peak_fd4, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak = cg_read_long_fd(peak_fd);
+	if (peak > MB(30) || peak < 0)
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(50))
+		goto cleanup;
+
+	/* Make sure everything is back to normal */
+	peak = cg_read_long_fd(peak_fd);
+	if (peak < MB(50))
+		goto cleanup;
+
+	peak = cg_read_long_fd(peak_fd4);
+	if (peak < MB(50))
+		goto cleanup;
+
+	fd3_closed = true;
+	if (close(peak_fd3))
+		goto cleanup;
+
+	fd4_closed = true;
+	if (close(peak_fd4))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
+	close(peak_fd);
+	if (!fd2_closed)
+		close(peak_fd2);
+	if (!fd3_closed)
+		close(peak_fd3);
+	if (!fd4_closed)
+		close(peak_fd4);
 	cg_destroy(memcg);
 	free(memcg);
 
@@ -817,13 +910,16 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
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
+
+	static const char reset_string[] = "reset\n";
 
 	if (!is_swap_enabled())
 		return KSFT_SKIP;
@@ -840,6 +936,45 @@ static int test_memcg_swap_max(const char *root)
 		goto cleanup;
 	}
 
+	int swap_peak_fd = cg_open(memcg, "memory.swap.peak",
+				   O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (swap_peak_fd == -1)
+		goto cleanup;
+
+	int mem_peak_fd = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (mem_peak_fd == -1)
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.peak"))
+		goto cleanup;
+
+	if (cg_read_long_fd(swap_peak_fd))
+		goto cleanup;
+
+	/* switch the swap and mem fds into local-peak tracking mode*/
+	int peak_reset = write(swap_peak_fd, reset_string, sizeof(reset_string));
+
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	if (cg_read_long_fd(swap_peak_fd))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak"))
+		goto cleanup;
+
+	if (cg_read_long_fd(mem_peak_fd))
+		goto cleanup;
+
+	peak_reset = write(mem_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	if (cg_read_long_fd(mem_peak_fd))
+		goto cleanup;
+
 	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
 		goto cleanup;
 
@@ -862,6 +997,61 @@ static int test_memcg_swap_max(const char *root)
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
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	/*
+	 * open, reset and close the peak swap on another FD to make sure
+	 * multiple extant fds don't corrupt the linked-list
+	 */
+	peak_reset = cg_write(memcg, "memory.swap.peak", (char *)reset_string);
+	if (peak_reset)
+		goto cleanup;
+
+	peak_reset = cg_write(memcg, "memory.peak", (char *)reset_string);
+	if (peak_reset)
+		goto cleanup;
+
+	/* actually reset on the fds */
+	peak_reset = write(swap_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak_reset = write(mem_peak_fd, reset_string, sizeof(reset_string));
+	if (peak_reset != sizeof(reset_string))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak > MB(10))
+		goto cleanup;
+
+	/*
+	 * The cgroup is now empty, but there may be a page or two associated
+	 * with the open FD accounted to it.
+	 */
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak > MB(1))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.peak") < MB(29))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.swap.peak") < MB(29))
+		goto cleanup;
+
 	if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
 		goto cleanup;
 
@@ -869,9 +1059,29 @@ static int test_memcg_swap_max(const char *root)
 	if (max <= 0)
 		goto cleanup;
 
+	peak = cg_read_long(memcg, "memory.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long(memcg, "memory.swap.peak");
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(mem_peak_fd);
+	if (peak < MB(29))
+		goto cleanup;
+
+	peak = cg_read_long_fd(swap_peak_fd);
+	if (peak < MB(19))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
+	if (close(mem_peak_fd))
+		ret = KSFT_FAIL;
+	if (close(swap_peak_fd))
+		ret = KSFT_FAIL;
 	cg_destroy(memcg);
 	free(memcg);
 
@@ -1295,7 +1505,7 @@ struct memcg_test {
 	const char *name;
 } tests[] = {
 	T(test_memcg_subtree_control),
-	T(test_memcg_current),
+	T(test_memcg_current_peak),
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
@@ -1303,7 +1513,7 @@ struct memcg_test {
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


