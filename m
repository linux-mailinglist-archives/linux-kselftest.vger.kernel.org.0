Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB428767A70
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 03:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjG2BCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjG2BCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 21:02:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F24211
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 18:01:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RCR240f89zLnsR;
        Sat, 29 Jul 2023 08:58:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 09:00:41 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] kunit: fix wild-memory-access bug in kunit_filter_suites()
Date:   Sat, 29 Jul 2023 09:00:03 +0800
Message-ID: <20230729010003.4058582-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for kunit_filter_suites(), When the filters arg = NULL, such as
the call of kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err)
in filter_suites_test() tese case in kunit, both filter_count and
parsed_filters will not be initialized.

So it's possible to enter kunit_filter_attr_tests(), and the use of
uninitialized parsed_filters will cause below wild-memory-access.

 RIP: 0010:kunit_filter_suites+0x780/0xa40
 Code: fe ff ff e8 42 87 4d ff 41 83 c6 01 49 83 c5 10 49 89 dc 44 39 74 24 50 0f 8e 81 fe ff ff e8 27 87 4d ff 4c 89 e8 48 c1 e8 03 <66> 42 83 3c 38 00 0f 85 af 01 00 00 49 8b 75 00 49 8b 55 08 4c 89
 RSP: 0000:ff1100010743fc38 EFLAGS: 00010203
 RAX: 03fc4400041d0ff1 RBX: ff1100010389a900 RCX: ffffffff9f940ad9
 RDX: ff11000107429740 RSI: 0000000000000000 RDI: ff110001037ec920
 RBP: ff1100010743fd50 R08: 0000000000000000 R09: ffe21c0020e87f1e
 R10: 0000000000000003 R11: 0000000000032001 R12: ff110001037ec800
 R13: 1fe2200020e87f8c R14: 0000000000000000 R15: dffffc0000000000
 FS:  0000000000000000(0000) GS:ff1100011b000000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ff11000115201000 CR3: 0000000113066001 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? die_addr+0x3c/0xa0
  ? exc_general_protection+0x148/0x220
  ? asm_exc_general_protection+0x26/0x30
  ? kunit_filter_suites+0x779/0xa40
  ? kunit_filter_suites+0x780/0xa40
  ? kunit_filter_suites+0x779/0xa40
  ? __pfx_kunit_filter_suites+0x10/0x10
  ? __pfx_kfree+0x10/0x10
  ? kunit_add_action_or_reset+0x3d/0x50
  filter_suites_test+0x1b7/0x440
  ? __pfx_filter_suites_test+0x10/0x10
  ? __pfx___schedule+0x10/0x10
  ? try_to_wake_up+0xa8e/0x1210
  ? _raw_spin_lock_irqsave+0x86/0xe0
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  ? set_cpus_allowed_ptr+0x7c/0xb0
  kunit_try_run_case+0x119/0x270
  ? __kthread_parkme+0xdc/0x160
  ? __pfx_kunit_try_run_case+0x10/0x10
  kunit_generic_run_threadfn_adapter+0x4e/0xa0
  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
  kthread+0x2c7/0x3c0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2c/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>
 Modules linked in:
 Dumping ftrace buffer:
    (ftrace buffer empty)
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:kunit_filter_suites+0x780/0xa40
 Code: fe ff ff e8 42 87 4d ff 41 83 c6 01 49 83 c5 10 49 89 dc 44 39 74 24 50 0f 8e 81 fe ff ff e8 27 87 4d ff 4c 89 e8 48 c1 e8 03 <66> 42 83 3c 38 00 0f 85 af 01 00 00 49 8b 75 00 49 8b 55 08 4c 89
 RSP: 0000:ff1100010743fc38 EFLAGS: 00010203
 RAX: 03fc4400041d0ff1 RBX: ff1100010389a900 RCX: ffffffff9f940ad9
 RDX: ff11000107429740 RSI: 0000000000000000 RDI: ff110001037ec920
 RBP: ff1100010743fd50 R08: 0000000000000000 R09: ffe21c0020e87f1e
 R10: 0000000000000003 R11: 0000000000032001 R12: ff110001037ec800
 R13: 1fe2200020e87f8c R14: 0000000000000000 R15: dffffc0000000000
 FS:  0000000000000000(0000) GS:ff1100011b000000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ff11000115201000 CR3: 0000000113066001 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Kernel panic - not syncing: Fatal exception
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: 0x1da00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 Rebooting in 1 seconds..

Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- add fixes tag
---
 lib/kunit/executor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 483f7b7873a7..5b5bed1efb93 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -125,7 +125,8 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 						char *filter_action,
 					    int *err)
 {
-	int i, j, k, filter_count;
+	int i, j, k;
+	int filter_count = 0;
 	struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
 	struct suite_set filtered;
 	struct kunit_glob_filter parsed_glob;
-- 
2.34.1

