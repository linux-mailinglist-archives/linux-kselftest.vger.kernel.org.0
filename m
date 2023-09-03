Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC1790B1D
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjICHLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjICHLK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 03:11:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C25197
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 00:11:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RdjYp4YYHz1M8k3;
        Sun,  3 Sep 2023 15:09:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 15:11:01 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 3/4] kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
Date:   Sun, 3 Sep 2023 15:10:27 +0800
Message-ID: <20230903071028.1518913-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903071028.1518913-1-ruanjinjie@huawei.com>
References: <20230903071028.1518913-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inject fault while probing kunit-example-test.ko, if kzalloc fails
in kunit_parse_glob_filter(), strcpy() or strncpy() to NULL will
cause below null-ptr-deref bug. So check NULL for kzalloc() and
return int instead of void for kunit_parse_glob_filter().

 Unable to handle kernel paging request at virtual address dfff800000000000
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 [dfff800000000000] address between user and kernel address ranges
 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
 Modules linked in: kunit_example_test cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
 CPU: 4 PID: 6047 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230829+ #141
 Hardware name: linux,dummy-virt (DT)
 pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : strncpy+0x58/0xc0
 lr : kunit_filter_suites+0x15c/0xa84
 sp : ffff800082a17420
 x29: ffff800082a17420 x28: 0000000000000000 x27: 0000000000000004
 x26: 0000000000000000 x25: ffffa847e40a5320 x24: 0000000000000001
 x23: 0000000000000000 x22: 0000000000000001 x21: dfff800000000000
 x20: 000000000000002a x19: 0000000000000000 x18: 00000000750b3b54
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000000 x13: 34393178302f3039 x12: ffff7508fcea4ec1
 x11: 1ffff508fcea4ec0 x10: ffff7508fcea4ec0 x9 : dfff800000000000
 x8 : ffff6051b1a7f86a x7 : ffff800082a17270 x6 : 0000000000000002
 x5 : 0000000000000098 x4 : ffff028d9817b250 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffffa847e40a5320 x0 : 0000000000000000
 Call trace:
  strncpy+0x58/0xc0
  kunit_filter_suites+0x15c/0xa84
  kunit_module_notify+0x1b0/0x3ac
  blocking_notifier_call_chain+0xc4/0x128
  do_init_module+0x250/0x594
  load_module+0x37b0/0x44b4
  init_module_from_file+0xd4/0x128
  idempotent_init_module+0x2c8/0x524
  __arm64_sys_finit_module+0xac/0x100
  invoke_syscall+0x6c/0x258
  el0_svc_common.constprop.0+0x160/0x22c
  do_el0_svc+0x44/0x5c
  el0_svc+0x38/0x78
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194
 Code: 5400028a d343fe63 12000a62 39400034 (38f56863)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x284761400000 from 0xffff800080000000
 PHYS_OFFSET: 0xfffffd7380000000
 CPU features: 0x88000203,3c020000,1000421b
 Memory Limit: none
 Rebooting in 1 seconds..

Fixes: a127b154a8f2 ("kunit: tool: allow filtering test cases via glob")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v2:
- goto the new add identical purpose free_copy label.
---
 lib/kunit/executor.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 0eda42b0c9bb..28f144de748b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -65,7 +65,7 @@ struct kunit_glob_filter {
 };
 
 /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
-static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
+static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
 	const int len = strlen(filter_glob);
@@ -73,16 +73,28 @@ static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 
 	if (!period) {
 		parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
+		if (!parsed->suite_glob)
+			return -ENOMEM;
+
 		parsed->test_glob = NULL;
 		strcpy(parsed->suite_glob, filter_glob);
-		return;
+		return 0;
 	}
 
 	parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
+	if (!parsed->suite_glob)
+		return -ENOMEM;
+
 	parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
+	if (!parsed->test_glob) {
+		kfree(parsed->suite_glob);
+		return -ENOMEM;
+	}
 
 	strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
 	strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
+
+	return 0;
 }
 
 /* Create a copy of suite with only tests that match test_glob. */
@@ -152,8 +164,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	}
 	copy_start = copy;
 
-	if (filter_glob)
-		kunit_parse_glob_filter(&parsed_glob, filter_glob);
+	if (filter_glob) {
+		*err = kunit_parse_glob_filter(&parsed_glob, filter_glob);
+		if (*err)
+			goto free_copy;
+	}
 
 	/* Parse attribute filters */
 	if (filters) {
-- 
2.34.1

