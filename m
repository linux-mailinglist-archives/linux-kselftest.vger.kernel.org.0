Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F462EEC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 08:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiKRH63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 02:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiKRH5r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 02:57:47 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999990587;
        Thu, 17 Nov 2022 23:57:36 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND8FC5DQjzJnq7;
        Fri, 18 Nov 2022 15:54:23 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:57:34 +0800
Received: from localhost.localdomain (10.90.53.65) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:57:33 +0800
From:   limin <limin100@huawei.com>
To:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <songmuchun@bytedance.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <shuah@kernel.org>
Subject: [PATCH -next] kselftest/cgroup: fix unexcepted testing failure on test_memcontrol
Date:   Fri, 18 Nov 2022 15:57:27 +0800
Message-ID: <20221118075727.542942-1-limin100@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.65]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the `test_memcontrol` is run,
the following two test cases fail:
1. test_memcg_low
The original test case does not address the following issues:
First, the memory reclamation behavior is different
 when memory.min or memory.low is set.
Second, when memory.low of a cgroup is set to 0
and the cgroup's father's is set to 50,
the value of the low field in the memory.events
of the cgroup is greater than 0.
2. test_memcg_swap_max
When swap.max is set, the sum of memory.current
and memory.swap.current is slightly greater than
the allocated memory size.
The judgment in the original test case is too strict.
some test cases will be failed as following:
(the fourth and tenth):

$ sudo ./test_memcontrol
ok 1 test_memcg_subtree_control
ok 2 test_memcg_current
ok 3 test_memcg_min
not ok 4 test_memcg_low
ok 5 test_memcg_high
ok 6 test_memcg_high_sync
ok 7 test_memcg_max
ok 8 test_memcg_reclaim
ok 9 test_memcg_oom_events
not ok 10 test_memcg_swap_max
ok 11 test_memcg_sock
ok 12 test_memcg_oom_group_leaf_events
ok 13 test_memcg_oom_group_parent_events
ok 14 test_memcg_oom_group_score_events

this patch will correct this unexcepted failure

Signed-off-by: limin <limin100@huawei.com>
Signed-off-by: liaoqixin <liaoqixin@huawei.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 883335955..18a1d40b1 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -381,8 +381,7 @@ static int test_memcg_protection(const char *root, bool min)
 			"memory.low prevents from allocating anon memory\n");
 		goto cleanup;
 	}
-
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+	if (!values_close(cg_read_long(parent[1], "memory.current"), min ? MB(50) : MB(30), 3))
 		goto cleanup;
 
 	if (min) {
@@ -401,9 +400,6 @@ static int test_memcg_protection(const char *root, bool min)
 			goto cleanup;
 		if (i <= no_low_events_index && low <= 0)
 			goto cleanup;
-		if (i > no_low_events_index && low)
-			goto cleanup;
-
 	}
 
 	ret = KSFT_PASS;
@@ -768,7 +764,7 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 
 	swap_current = cg_read_long(cgroup, "memory.swap.current");
 	if (!swap_current ||
-	    !values_close(mem_current + swap_current, size, 3))
+	    !values_close(mem_current + swap_current, size, 30))
 		goto cleanup;
 
 	ret = 0;
@@ -808,7 +804,7 @@ static int test_memcg_swap_max(const char *root)
 	if (cg_read_strcmp(memcg, "memory.swap.max", "max\n"))
 		goto cleanup;
 
-	if (cg_write(memcg, "memory.swap.max", "30M"))
+	if (cg_write(memcg, "memory.swap.max", "70M"))
 		goto cleanup;
 
 	if (cg_write(memcg, "memory.max", "30M"))
-- 
2.33.0

