Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57150AC3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442733AbiDUXrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 19:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442751AbiDUXrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 19:47:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993648893
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x23-20020a170902b41700b0015906c1ea31so3278704plr.20
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=soZcA9y3PeE+zbNMS5WF05IaFn1Ub9nCQnWDGl/9EM4=;
        b=AMOxrzCggH4xAXjA65k6jRVjeYiHvCQ4JBuinSbQFuHWjpOZVImwxNzZ4vHPZohQTB
         aXciCJTbhyQ9+Fe7fHynuCvh/GMWKc3btZ9Y358IdMT3cFDnaS8nhl8U83WMeiZ8Ithp
         MPQW59CsoBRg/kR2IuaK+bMzzTxWWtYyKW/Dy7he+lQj4bZ/W17RnhFraPRXsfm66/d7
         5UbhQH01hqjEcs/bA2iTiTpfx8hnyPldqhb6oZiRPAgE1LWc9rycFDzbTK1wLpo4gCLg
         /eJv/edTk29F2NU8C8gWTD76IZam53QbHxr/hDRN522g8VA/T1AOWy7SPpB7vGrVABsz
         FexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=soZcA9y3PeE+zbNMS5WF05IaFn1Ub9nCQnWDGl/9EM4=;
        b=Ee/G8rfM+hA1kFkwp/pW4tqXzTqSnhSgb60wXX1YrJ5br0tNU+pjSY8q0AzfQpMIs2
         j3+Gy6d80jQEmK9FILUzhVhra6E2wZ+C1vLfus+SSLwvx2R7Vj5BBhWyeBAl0q4QoZhj
         DfYcmf/EtweN+5zjngW6Ad5RinF/WWtWo5/LIXLjG7ys5emhQyG5qZipNd+thL2dXGdV
         6i7KUPl/JAzDzG5y0NF9B38MWuHanUorMR+JKZHTHmkPnr0dbjX/pBa5h00jnCXOjqNL
         zyU/6cqZ0ymnlhWysq9AsENwfpfU1OiZZCIThHMVP69+0NZtMcAWyuyoNXjDUZJ7U8jT
         iWSg==
X-Gm-Message-State: AOAM530YAuKril9NwjhfRPGx9oa1SobKaT4gUcHCcbwaKdKy1L8ZTgbA
        HIKeGRhtAljfRRAAhVqHwLmz+xFaNqaZI3XX
X-Google-Smtp-Source: ABdhPJz2CcjMs+n1pq6zI6202/dU8xhtLt6Efq3KS5h9gllRzFGCi7i+ft39wZ54kqGMAmjNN828QLIvEM5o94Aq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP
 id mr4-20020a17090b238400b001cb52239dc4mr191635pjb.1.1650584688532; Thu, 21
 Apr 2022 16:44:48 -0700 (PDT)
Date:   Thu, 21 Apr 2022 23:44:26 +0000
In-Reply-To: <20220421234426.3494842-1-yosryahmed@google.com>
Message-Id: <20220421234426.3494842-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 4/4] selftests: cgroup: add a selftest for memory.reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new test for memory.reclaim that verifies that the interface
correctly reclaims memory as intended, from both anon and file pages.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/cgroup/test_memcontrol.c        | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index f2ffb3a30194..5f7c20de2426 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -760,6 +760,91 @@ static int test_memcg_max(const char *root)
 	return ret;
 }
 
+/*
+ * This test checks that memory.reclaim reclaims the given
+ * amount of memory (from both anon and file).
+ */
+static int test_memcg_reclaim(const char *root)
+{
+	int ret = KSFT_FAIL, fd, retries;
+	char *memcg;
+	long current, to_reclaim;
+	char buf[64];
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	current = cg_read_long(memcg, "memory.current");
+	if (current != 0)
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(50));
+	sleep(1);
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
+	sleep(1);
+
+	current = cg_read_long(memcg, "memory.current");
+	if (!values_close(current, MB(100), 10))
+		goto cleanup;
+
+	/*
+	 * Reclaim until current reaches 30M, make sure to reclaim over 50M to
+	 * hit both anon and file.
+	 */
+	retries = 5;
+	while (true) {
+		int err;
+
+		current = cg_read_long(memcg, "memory.current");
+		to_reclaim = current - MB(30);
+
+		/*
+		 * We only keep looping if we get EAGAIN, which means we could
+		 * not reclaim the full amount.
+		 */
+		if (to_reclaim <= 0)
+			goto cleanup;
+
+
+		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
+		err = cg_write(memcg, "memory.reclaim", buf);
+		if (!err) {
+			/*
+			 * If writing succeeds, then the written amount should have been
+			 * fully reclaimed (and maybe more).
+			 */
+			current = cg_read_long(memcg, "memory.current");
+			if (!values_close(current, MB(30), 3) && current > MB(30))
+				goto cleanup;
+			break;
+		}
+
+		/* The kernel could not reclaim the full amount, try again. */
+		if (err == -EAGAIN && retries--)
+			continue;
+
+		/* We got an unexpected error or ran out of retries. */
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+	close(fd);
+
+	return ret;
+}
+
 static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 {
 	long mem_max = (long)arg;
@@ -1263,6 +1348,7 @@ struct memcg_test {
 	T(test_memcg_high),
 	T(test_memcg_high_sync),
 	T(test_memcg_max),
+	T(test_memcg_reclaim),
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
 	T(test_memcg_sock),
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

