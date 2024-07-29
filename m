Return-Path: <linux-kselftest+bounces-14397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E4940052
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415D41C21585
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3418E74A;
	Mon, 29 Jul 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="M/XK7BsX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358C18D4D6
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288185; cv=none; b=FYQr8VbUQ6NBIYXU4XDwTzm/gwBZOi+2wMSxF06VXWbCL6O5ATgFGk7RvFLbNkYy9Yk6wmmbPTiJCosi4oGmw4+6bqg0C9bQtwlf8+H/Xld1SbdYIdxbYVopLBy16wGDJ+80iWuNxrnk4OBuPK9wWQWoAfy9AipR5DE+9hKCDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288185; c=relaxed/simple;
	bh=mV20kFAXH41ztz8wYbzf9MoSExP42SEu0mNOk+vb0fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c96bc9YGMjMe88eGRSV231upYkJ2lSgcAhhGHyoC0r8QJvU4+zSNnsWCX8shZ219+1YbnOuvdfl2Bpt9ZX2/Hx5yNmJdxdYLKKzIvDUJoG7Gmi6bL6OP8JMwm9Ct95rOmYYHT3jJsJ2aMMXO99oXonrGwbub7SuwLk8ulTLuaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=M/XK7BsX; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1722288182; x=1722295382;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=H3UMxB4M7BrujHBPr+UgcfPfxgI2rlDhcD8iL3igSy4=;
 b=M/XK7BsXSHOLe84nAHAP6i7AQUWOWpeNieQQpAzlDNlm1zDrk3+8SRY3v7RESQbawpx0wg+D+ZpzBSF6McFuOLRdlvlCbgS8Vra0Bz1A2wz3FqttSqkjGR9z0ovXZiwZmVgRFMVf2QDwPm2kiiYuDzZ7yW2zAEb6ciDNxA2xLJ4=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 5a80eff7c455 with SMTP id 66a808364527901af3858a2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jul 2024 21:23:02 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-7f6ba6de-loec.c.vimeo-core.internal [10.56.27.213])
	by smtp.vimeo.com (Postfix) with ESMTP id 17B7C65CBB;
	Mon, 29 Jul 2024 21:23:02 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 0D850B40AC9; Mon, 29 Jul 2024 10:38:11 -0400 (EDT)
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
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	David Finkel <davidf@vimeo.com>
Subject: [PATCH v6 2/2] mm, memcg: cg2 memory{.swap,}.peak write tests
Date: Mon, 29 Jul 2024 10:37:43 -0400
Message-Id: <20240729143743.34236-3-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240729143743.34236-1-davidf@vimeo.com>
References: <20240729143743.34236-1-davidf@vimeo.com>
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
 .../selftests/cgroup/test_memcontrol.c        | 229 +++++++++++++++++-
 3 files changed, 245 insertions(+), 8 deletions(-)

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
index 41ae8047b8895..f54c1f75b6da7 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -161,13 +161,15 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
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
+	bool fd2_closed = false, fd3_closed = false, fd4_closed = false;
+	int peak_fd = -1, peak_fd2 = -1, peak_fd3 = -1, peak_fd4 = -1;
 
 	memcg = cg_name(root, "memcg_test");
 	if (!memcg)
@@ -180,15 +182,108 @@ static int test_memcg_current(const char *root)
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
+	peak_fd = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd == -1)
+		goto cleanup;
+
+	peak_fd2 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd2 == -1)
+		goto cleanup;
+
+	peak_fd3 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
+
+	if (peak_fd3 == -1)
+		goto cleanup;
+
+	/* any non-empty string resets, but make it clear */
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
+	peak_fd4 = cg_open(memcg, "memory.peak", O_RDWR | O_APPEND | O_CLOEXEC);
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
 
@@ -817,13 +912,17 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
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
+	/* any non-empty string resets */
+	static const char reset_string[] = "foobarbaz";
 
 	if (!is_swap_enabled())
 		return KSFT_SKIP;
@@ -840,6 +939,45 @@ static int test_memcg_swap_max(const char *root)
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
 
@@ -862,6 +1000,61 @@ static int test_memcg_swap_max(const char *root)
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
 
@@ -869,9 +1062,29 @@ static int test_memcg_swap_max(const char *root)
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
 
@@ -1295,7 +1508,7 @@ struct memcg_test {
 	const char *name;
 } tests[] = {
 	T(test_memcg_subtree_control),
-	T(test_memcg_current),
+	T(test_memcg_current_peak),
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
@@ -1303,7 +1516,7 @@ struct memcg_test {
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


