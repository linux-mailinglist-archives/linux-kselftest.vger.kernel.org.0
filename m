Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42052C0B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiERQTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiERQTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 12:19:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C81EE081;
        Wed, 18 May 2022 09:19:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B7DD21BAB;
        Wed, 18 May 2022 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652890753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MgDcGy2HGZHoFIxp9YRQq/LcvV4yVV/hIqOQDLhYAM0=;
        b=ezfRN2AIIGjl/CefJvBF7rwajbzilhILeOycFOxvDvIufHeNNtOY9guxyG2loFT2LBwMqy
        7Ps8hJkPdxQ2eX8TSKkzlJHLAd+8rH0KgL8dIgIh3CKWAnvWUnvHAmbUFF12o1FN7yJT5j
        9k5j+9as1w/HQBMiXZ7WK0eWzZrij9s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5CB213ADC;
        Wed, 18 May 2022 16:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eM1eM4AchWLqZAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 16:19:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH v2 5/5] selftests: memcg: Factor out common parts of memory.{low,min} tests
Date:   Wed, 18 May 2022 18:18:59 +0200
Message-Id: <20220518161859.21565-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518161859.21565-1-mkoutny@suse.com>
References: <20220518161859.21565-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The memory protection test setup and runtime is almost equal for
memory.low and memory.min cases.
It makes modification of the common parts prone to mistakes, since the
protections are similar not only in setup but also in principle, factor
the common part out.

Past exceptions between the tests:
- missing memory.min is fine (kept),
- test_memcg_low protected orphaned pagecache (adapted like
  test_memcg_min and we keep the processes of protected memory running).

The evaluation in two tests is different (OOM of allocator vs low events
of protégés), this is kept different.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 199 ++++--------------
 1 file changed, 36 insertions(+), 163 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 63c6a683a8c1..c3d0d5f7b19c 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -190,13 +190,6 @@ static int test_memcg_current(const char *root)
 	return ret;
 }
 
-static int alloc_pagecache_50M(const char *cgroup, void *arg)
-{
-	int fd = (long)arg;
-
-	return alloc_pagecache(fd, MB(50));
-}
-
 static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 {
 	int fd = (long)arg;
@@ -254,7 +247,9 @@ static int cg_test_proc_killed(const char *cgroup)
  * A/B/E   memory.min = 0,    memory.current = 50M
  * A/B/F   memory.min = 500M, memory.current = 0
  *
- * Usages are pagecache, but the test keeps a running
+ * (or memory.low if we test soft protection)
+ *
+ * Usages are pagecache and the test keeps a running
  * process in every leaf cgroup.
  * Then it creates A/G and creates a significant
  * memory pressure in A.
@@ -268,15 +263,16 @@ static int cg_test_proc_killed(const char *cgroup)
  * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
- * unprotected memory in A available, and checks
- * checks that memory.min protects pagecache even
- * in this case.
+ * unprotected memory in A available, and checks that:
+ * a) memory.min protects pagecache even in this case,
+ * b) memory.low allows reclaiming page cache with low events.
  */
-static int test_memcg_min(const char *root)
+static int test_memcg_protection(const char *root, bool min)
 {
-	int ret = KSFT_FAIL;
+	int ret = KSFT_FAIL, rc;
 	char *parent[3] = {NULL};
 	char *children[4] = {NULL};
+	const char *attribute = min ? "memory.min" : "memory.low";
 	long c[4];
 	int i, attempts;
 	int fd;
@@ -300,8 +296,10 @@ static int test_memcg_min(const char *root)
 	if (cg_create(parent[0]))
 		goto cleanup;
 
-	if (cg_read_long(parent[0], "memory.min")) {
-		ret = KSFT_SKIP;
+	if (cg_read_long(parent[0], attribute)) {
+		/* No memory.min on older kernels is fine */
+		if (min)
+			ret = KSFT_SKIP;
 		goto cleanup;
 	}
 
@@ -338,15 +336,15 @@ static int test_memcg_min(const char *root)
 			      (void *)(long)fd);
 	}
 
-	if (cg_write(parent[1], "memory.min", "50M"))
+	if (cg_write(parent[1],   attribute, "50M"))
 		goto cleanup;
-	if (cg_write(children[0], "memory.min", "75M"))
+	if (cg_write(children[0], attribute, "75M"))
 		goto cleanup;
-	if (cg_write(children[1], "memory.min", "25M"))
+	if (cg_write(children[1], attribute, "25M"))
 		goto cleanup;
-	if (cg_write(children[2], "memory.min", "0"))
+	if (cg_write(children[2], attribute, "0"))
 		goto cleanup;
-	if (cg_write(children[3], "memory.min", "500M"))
+	if (cg_write(children[3], attribute, "500M"))
 		goto cleanup;
 
 	attempts = 0;
@@ -375,161 +373,26 @@ static int test_memcg_min(const char *root)
 	if (c[3] != 0)
 		goto cleanup;
 
-	if (!cg_run(parent[2], alloc_anon, (void *)MB(170)))
-		goto cleanup;
-
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
-		goto cleanup;
-
-	ret = KSFT_PASS;
-
-cleanup:
-	for (i = ARRAY_SIZE(children) - 1; i >= 0; i--) {
-		if (!children[i])
-			continue;
-
-		cg_destroy(children[i]);
-		free(children[i]);
-	}
-
-	for (i = ARRAY_SIZE(parent) - 1; i >= 0; i--) {
-		if (!parent[i])
-			continue;
-
-		cg_destroy(parent[i]);
-		free(parent[i]);
-	}
-	close(fd);
-	return ret;
-}
-
-/*
- * First, this test creates the following hierarchy:
- * A       memory.low = 0,    memory.max = 200M
- * A/B     memory.low = 50M
- * A/B/C   memory.low = 75M,  memory.current = 50M
- * A/B/D   memory.low = 25M,  memory.current = 50M
- * A/B/E   memory.low = 0,    memory.current = 50M
- * A/B/F   memory.low = 500M, memory.current = 0
- *
- * Usages are pagecache.
- * Then it creates A/G an creates a significant
- * memory pressure in it.
- *
- * Then it checks actual memory usages and expects that:
- * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 29M
- * A/B/D  memory.current ~= 21M
- * A/B/E  memory.current ~= 0
- * A/B/F  memory.current  = 0
- * (for origin of the numbers, see model in memcg_protection.m.)
- *
- * After that it tries to allocate more than there is
- * unprotected memory in A available,
- * and checks low and oom events in memory.events.
- */
-static int test_memcg_low(const char *root)
-{
-	int ret = KSFT_FAIL;
-	char *parent[3] = {NULL};
-	char *children[4] = {NULL};
-	long low, oom;
-	long c[4];
-	int i;
-	int fd;
-
-	fd = get_temp_fd();
-	if (fd < 0)
-		goto cleanup;
-
-	parent[0] = cg_name(root, "memcg_test_0");
-	if (!parent[0])
-		goto cleanup;
-
-	parent[1] = cg_name(parent[0], "memcg_test_1");
-	if (!parent[1])
-		goto cleanup;
-
-	parent[2] = cg_name(parent[0], "memcg_test_2");
-	if (!parent[2])
-		goto cleanup;
-
-	if (cg_create(parent[0]))
-		goto cleanup;
-
-	if (cg_read_long(parent[0], "memory.low"))
-		goto cleanup;
-
-	if (cg_write(parent[0], "cgroup.subtree_control", "+memory"))
+	rc = cg_run(parent[2], alloc_anon, (void *)MB(170));
+	if (min && !rc)
 		goto cleanup;
-
-	if (cg_write(parent[0], "memory.max", "200M"))
-		goto cleanup;
-
-	if (cg_write(parent[0], "memory.swap.max", "0"))
-		goto cleanup;
-
-	if (cg_create(parent[1]))
-		goto cleanup;
-
-	if (cg_write(parent[1], "cgroup.subtree_control", "+memory"))
-		goto cleanup;
-
-	if (cg_create(parent[2]))
+	else if (!min && rc) {
+		fprintf(stderr,
+			"memory.low prevents from allocating anon memory\n");
 		goto cleanup;
-
-	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		children[i] = cg_name_indexed(parent[1], "child_memcg", i);
-		if (!children[i])
-			goto cleanup;
-
-		if (cg_create(children[i]))
-			goto cleanup;
-
-		if (i > 2)
-			continue;
-
-		if (cg_run(children[i], alloc_pagecache_50M, (void *)(long)fd))
-			goto cleanup;
 	}
 
-	if (cg_write(parent[1], "memory.low", "50M"))
-		goto cleanup;
-	if (cg_write(children[0], "memory.low", "75M"))
-		goto cleanup;
-	if (cg_write(children[1], "memory.low", "25M"))
-		goto cleanup;
-	if (cg_write(children[2], "memory.low", "0"))
-		goto cleanup;
-	if (cg_write(children[3], "memory.low", "500M"))
-		goto cleanup;
-
-	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
-		goto cleanup;
-
 	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
 		goto cleanup;
 
-	for (i = 0; i < ARRAY_SIZE(children); i++)
-		c[i] = cg_read_long(children[i], "memory.current");
-
-	if (!values_close(c[0], MB(29), 10))
-		goto cleanup;
-
-	if (!values_close(c[1], MB(21), 10))
-		goto cleanup;
-
-	if (c[3] != 0)
-		goto cleanup;
-
-	if (cg_run(parent[2], alloc_anon, (void *)MB(166))) {
-		fprintf(stderr,
-			"memory.low prevents from allocating anon memory\n");
+	if (min) {
+		ret = KSFT_PASS;
 		goto cleanup;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
 		int no_low_events_index = 1;
+		long low, oom;
 
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
 		low = cg_read_key_long(children[i], "memory.events", "low ");
@@ -565,6 +428,16 @@ static int test_memcg_low(const char *root)
 	return ret;
 }
 
+static int test_memcg_min(const char *root)
+{
+	return test_memcg_protection(root, true);
+}
+
+static int test_memcg_low(const char *root)
+{
+	return test_memcg_protection(root, false);
+}
+
 static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 {
 	size_t size = MB(50);
-- 
2.35.3

