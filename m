Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0178E712
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjHaHRP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHaHRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2191A3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 00:17:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RbsrK2M57zrRyt;
        Thu, 31 Aug 2023 15:15:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 15:17:09 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 1/4] kunit: Fix wild-memory-access bug in kunit_free_suite_set()
Date:   Thu, 31 Aug 2023 15:16:52 +0800
Message-ID: <20230831071655.2907683-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831071655.2907683-1-ruanjinjie@huawei.com>
References: <20230831071655.2907683-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inject fault while probing kunit-example-test.ko, if kstrdup()
fails in mod_sysfs_setup() in load_module(), the mod->state will
switch from MODULE_STATE_COMING to MODULE_STATE_GOING instead of
from MODULE_STATE_LIVE to MODULE_STATE_GOING, so only
kunit_module_exit() will be called without kunit_module_init(), and
the mod->kunit_suites is no set correctly and the free in
kunit_free_suite_set() will cause below wild-memory-access bug.

The mod->state state machine when load_module() succeeds:

MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
	 ^						|
	 |						| delete_module
	 +---------------- MODULE_STATE_GOING <---------+

The mod->state state machine when load_module() fails at
mod_sysfs_setup():

MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
	^						|
	|						|
	+-----------------------------------------------+

Call kunit_module_init() at MODULE_STATE_COMING state to fix the issue
because MODULE_STATE_LIVE is transformed from it.

 Unable to handle kernel paging request at virtual address ffffff341e942a88
 KASAN: maybe wild-memory-access in range [0x0003f9a0f4a15440-0x0003f9a0f4a15447]
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000441ea000
 [ffffff341e942a88] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
 Modules linked in: kunit_example_test(-) cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
 CPU: 3 PID: 2035 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230828+ #136
 Hardware name: linux,dummy-virt (DT)
 pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kfree+0x2c/0x70
 lr : kunit_free_suite_set+0xcc/0x13c
 sp : ffff8000829b75b0
 x29: ffff8000829b75b0 x28: ffff8000829b7b90 x27: 0000000000000000
 x26: dfff800000000000 x25: ffffcd07c82a7280 x24: ffffcd07a50ab300
 x23: ffffcd07a50ab2e8 x22: 1ffff00010536ec0 x21: dfff800000000000
 x20: ffffcd07a50ab2f0 x19: ffffcd07a50ab2f0 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: ffffcd07c24b6764
 x14: ffffcd07c24b63c0 x13: ffffcd07c4cebb94 x12: ffff700010536ec7
 x11: 1ffff00010536ec6 x10: ffff700010536ec6 x9 : dfff800000000000
 x8 : 00008fffefac913a x7 : 0000000041b58ab3 x6 : 0000000000000000
 x5 : 1ffff00010536ec5 x4 : ffff8000829b7628 x3 : dfff800000000000
 x2 : ffffff341e942a80 x1 : ffffcd07a50aa000 x0 : fffffc0000000000
 Call trace:
  kfree+0x2c/0x70
  kunit_free_suite_set+0xcc/0x13c
  kunit_module_notify+0xd8/0x360
  blocking_notifier_call_chain+0xc4/0x128
  load_module+0x382c/0x44a4
  init_module_from_file+0xd4/0x128
  idempotent_init_module+0x2c8/0x524
  __arm64_sys_finit_module+0xac/0x100
  invoke_syscall+0x6c/0x258
  el0_svc_common.constprop.0+0x160/0x22c
  do_el0_svc+0x44/0x5c
  el0_svc+0x38/0x78
  el0t_64_sync_handler+0x13c/0x158
  el0t_64_sync+0x190/0x194
 Code: aa0003e1 b25657e0 d34cfc42 8b021802 (f9400440)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x4d0742200000 from 0xffff800080000000
 PHYS_OFFSET: 0xffffee43c0000000
 CPU features: 0x88000203,3c020000,1000421b
 Memory Limit: none
 Rebooting in 1 seconds..

Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..421f13981412 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -784,12 +784,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
-		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
+		kunit_module_init(mod);
+		break;
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-- 
2.34.1

