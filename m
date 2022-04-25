Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522D50E904
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiDYTEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbiDYTEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:04:07 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B17E07E8
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:01:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id g12-20020a170902740c00b0015d243ff163so1403205pll.19
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jNhmc3CPZ5vCVsb/llHs2xPQpQWQkNvnnQyZxpAVZvA=;
        b=Iq2S9Shz90p8NHXUzctrcXtVuymG0BHSMWdhf3g1aIk+jXNBHmBuLrOBkPz2g4i3wW
         I7e0S8dzX3XzREZmLBITiaxkxl465uGcVGpGess8no2z2MAudjeZ5DXw3Bxw73ZwGB7Q
         MRgm6I/dGRKXsHFripVwmfFPqfdFuclgGVwPjylXzWPgHqZNZPtB/1Jp2/oJ/W7F8y9S
         xGfsYuGC32TY9P82ZdD8i1tsMQF2qAPElU0/7vVYlioIFiFqD6K4zo+sVZzH9CF/FciX
         ais1AXji+6NbrGAuv46JxiDFpUDOZCEt5oQMPU1eKiljCUa03EJHxT2O52T/s7cWJYGy
         3zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jNhmc3CPZ5vCVsb/llHs2xPQpQWQkNvnnQyZxpAVZvA=;
        b=vvDReEFawvjI4V5WRKDKJ/+BbzMjYP3Vmnwxn7hADkM5zOa5l0YiMUJLNz3EaXaFDq
         9AeKdvtIbbhtyxVw2gBxILyC33JLFfgka64Q0QiG/08qZOmWIR8yvDjspW9zoF/pkv6i
         IL6VfJz9L+/n2koyKUZH0HbVa6egJxp2aKxKSnYF8irL+ze8VEwaze0kne9AiOBDRgHC
         zALeca+4+KOh4frG76djk9jkfOQhILEUpXPywf5/rKmsnYoY4p65GeFV0lzmnYcGLc30
         Rh0khLMPNno/gplohFs/YbpS0DeDvxX9IhC238PZjQvhtW8sykb/ViZdUU/wFayQTcBM
         cSeQ==
X-Gm-Message-State: AOAM532CUXalxPuFJJb3t6VOqu/KXVfQSolAn3sNW0UTyYRNbY2tzI6E
        q2T2MWDrS8DmzNujB/lyu/JS0MFLqK5Slwka
X-Google-Smtp-Source: ABdhPJx65fYn7YEk1pJGBjuWZR1gDqcxVKg0wWAyLHRkp/HuiCGSFGtSHC0vblXC2WzozjDBTDdEn4/m5NJEQ0y5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:9105:b0:1d2:9e98:7e1e with SMTP
 id k5-20020a17090a910500b001d29e987e1emr1604034pjo.0.1650913260401; Mon, 25
 Apr 2022 12:01:00 -0700 (PDT)
Date:   Mon, 25 Apr 2022 19:00:40 +0000
In-Reply-To: <20220425190040.2475377-1-yosryahmed@google.com>
Message-Id: <20220425190040.2475377-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220425190040.2475377-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v5 4/4] selftests: cgroup: add a selftest for memory.reclaim
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
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
 .../selftests/cgroup/test_memcontrol.c        | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index f2ffb3a30194..a9c691fb94c0 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -760,6 +760,111 @@ static int test_memcg_max(const char *root)
 	return ret;
 }
 
+/*
+ * This test checks that memory.reclaim reclaims the given
+ * amount of memory (from both anon and file, if possible).
+ */
+static int test_memcg_reclaim(const char *root)
+{
+	int ret = KSFT_FAIL, fd, retries;
+	char *memcg;
+	long current, expected_usage, to_reclaim;
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
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
+
+	/*
+	 * If swap is enabled, try to reclaim from both anon and file, else try
+	 * to reclaim from file only.
+	 */
+	if (is_swap_enabled()) {
+		cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(50));
+		expected_usage = MB(100);
+	} else
+		expected_usage = MB(50);
+
+	/*
+	 * Wait until current usage reaches the expected usage (or we run out of
+	 * retries).
+	 */
+	retries = 5;
+	while (!values_close(cg_read_long(memcg, "memory.current"),
+			    expected_usage, 10)) {
+		if (retries--) {
+			sleep(1);
+			continue;
+		} else {
+			fprintf(stderr,
+				"failed to allocate %ld for memcg reclaim test\n",
+				expected_usage);
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * Reclaim until current reaches 30M, this makes sure we hit both anon
+	 * and file if swap is enabled.
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
@@ -1263,6 +1368,7 @@ struct memcg_test {
 	T(test_memcg_high),
 	T(test_memcg_high_sync),
 	T(test_memcg_max),
+	T(test_memcg_reclaim),
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
 	T(test_memcg_sock),
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

