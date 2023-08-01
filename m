Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9576AA1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjHAHhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjHAHhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:37:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51A1BC8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 00:37:39 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFRkW1F6zzrRwx;
        Tue,  1 Aug 2023 15:36:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 15:37:36 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] kunit: fix possible memory leak in kunit_filter_suites()
Date:   Tue, 1 Aug 2023 15:37:00 +0800
Message-ID: <20230801073700.3740895-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inject fault while probing drm_kunit_helpers.ko, if one of
kunit_next_attr_filter(), kunit_filter_glob_tests() and
kunit_filter_attr_tests() fails, parsed_filters,
parsed_glob.suite_glob/test_glob alloced in
kunit_parse_glob_filter() is leaked.
And the filtered_suite->test_cases alloced in kunit_filter_glob_tests()
or kunit_filter_attr_tests() may also be leaked.

unreferenced object 0xff110001067e4800 (size 1024):
  comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
  hex dump (first 32 bytes):
    73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
    [<00000000e2f9cce9>] kmemdup+0x2c/0x60
    [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
    [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000105d79b00 (size 192):
  comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
  hex dump (first 32 bytes):
    f0 e1 5a 88 ff ff ff ff 60 59 bb 8a ff ff ff ff  ..Z.....`Y......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
    [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff110001067e6000 (size 1024):
  comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
  hex dump (first 32 bytes):
    73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
    [<00000000e2f9cce9>] kmemdup+0x2c/0x60
    [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
    [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000103f3a800 (size 96):
  comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
  hex dump (first 32 bytes):
    f0 e1 5a 88 ff ff ff ff 40 39 bb 8a ff ff ff ff  ..Z.....@9......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
    [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000101a72ac0 (size 16):
  comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.529s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 e0 2a a7 01 01 00 11 ff  .........*......
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
    [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000103caf880 (size 32):
  comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.547s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
    [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000101a72ae0 (size 16):
  comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 2b a7 01 01 00 11 ff  .........+......
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
    [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000103caf9c0 (size 32):
  comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
    [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
unreferenced object 0xff11000101a72b00 (size 16):
  comm "kunit_try_catch", pid 108, jiffies 4294671832 (age 763.529s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d6e4891>] __kmalloc+0x4d/0x140
    [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
    [<00000000881258cc>] filter_attr_skip_test+0x148/0x770
    [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
    [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
    [<00000000d195ac13>] kthread+0x2c7/0x3c0
    [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
    [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30

Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filter suites")
Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 lib/kunit/executor.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 5b5bed1efb93..481901d245d0 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -151,7 +151,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 		for (j = 0; j < filter_count; j++)
 			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
 		if (*err)
-			return filtered;
+			goto err;
 	}
 
 	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
@@ -163,7 +163,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					parsed_glob.test_glob);
 			if (IS_ERR(filtered_suite)) {
 				*err = PTR_ERR(filtered_suite);
-				return filtered;
+				goto err;
 			}
 		}
 		if (filter_count) {
@@ -172,15 +172,18 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 						parsed_filters[k], filter_action, err);
 
 				/* Free previous copy of suite */
-				if (k > 0 || filter_glob)
+				if (k > 0 || filter_glob) {
+					kfree(filtered_suite->test_cases);
 					kfree(filtered_suite);
+				}
+
 				filtered_suite = new_filtered_suite;
 
 				if (*err)
-					return filtered;
+					goto err;
 				if (IS_ERR(filtered_suite)) {
 					*err = PTR_ERR(filtered_suite);
-					return filtered;
+					goto err;
 				}
 				if (!filtered_suite)
 					break;
@@ -194,6 +197,10 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	}
 	filtered.end = copy;
 
+err:
+	if (*err)
+		kfree(copy);
+
 	if (filter_glob) {
 		kfree(parsed_glob.suite_glob);
 		kfree(parsed_glob.test_glob);
-- 
2.34.1

