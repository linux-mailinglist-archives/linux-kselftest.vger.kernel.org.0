Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029F7B16F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjI1JPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjI1JPl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:15:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F56AC
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 02:15:38 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rx74x6J6yztT2T;
        Thu, 28 Sep 2023 17:11:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:15:36 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <rmoar@google.com>,
        <marpagan@redhat.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH RESEND 3/3] kunit: Init and run test suites in the right state
Date:   Thu, 28 Sep 2023 17:14:46 +0800
Message-ID: <20230928091446.1209703-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928091446.1209703-1-ruanjinjie@huawei.com>
References: <20230928091446.1209703-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

As Marco pointed out, commit 2810c1e99867 ("kunit: Fix wild-memory-access
bug in kunit_free_suite_set()") causes test suites to run while the test
module is still in MODULE_STATE_COMING. In that state, the module
is not fully initialized, lacking sysfs, module_memory, args, init
function which causes null-ptr-deref of using fake devices below.

Since load_module() notify MODULE_STATE_COMING in prepare_coming_module(),
and then init sysfs and args etc. in parse_args() and mod_sysfs_setup(),
after that it notify MODULE_STATE_LIVE in do_init_module(), and fake driver
in the test suits depend on them. So the test suits should be executed when
notify MODULE_STATE_LIVE.

But the kunit_free_suite_set() in kunit_module_exit() depends on the
success of kunit_filter_suites() in kunit_module_init(). The best practice
is to alloc and init resource when notify MODULE_STATE_COMING and free them
when notify MODULE_STATE_GOING. So split the kunit_module_exec() from
kunit_module_init() to run test suits when MODULE_STATE_LIVE, call
kunit_filter_suites() and allocate memory in kunit_module_init() and call
kunit_free_suite_set() in kunit_module_exit() to free the memory.

So if load_module() succeeds and notify module state as below, it calls
kunit_module_init(), kunit_module_exec() and kunit_module_exit(), which
will work ok. The mod->state state machine when load_module() succeeds:

			      kunit_filter_suites()	kunit_module_exec()
    MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
             ^                                              |
             |                                              |
             +---------------- MODULE_STATE_GOING <---------+
			      kunit_free_suite_set()

If load_module() fails and notify module state as below, it call
kunit_module_init() and kunit_module_exit(), which will also work ok.
The mod->state state machine when load_module() fails at mod_sysfs_setup():

			      kunit_filter_suites()	kunit_free_suite_set()
    MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
            ^                                               |
            |                                               |
            +-----------------------------------------------+

 general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
 KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 CPU: 1 PID: 1868 Comm: modprobe Tainted: G        W        N 6.6.0-rc3+ #61
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:kobject_namespace+0x71/0x150
 Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
 RSP: 0018:ffff88810f797288 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000003 RSI: ffffffff847b4900 RDI: 0000000000000018
 RBP: ffff88810ba08940 R08: 0000000000000001 R09: ffffed1021ef2e0f
 R10: ffff88810f79707f R11: 746e756f63666572 R12: ffffffffa0241990
 R13: ffff88810ba08958 R14: ffff88810ba08968 R15: ffffffff84ac6c20
 FS:  00007ff9f2186540(0000) GS:ffff888119c80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fff73a2cff8 CR3: 000000010b77b002 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? die_addr+0x3d/0xa0
  ? exc_general_protection+0x144/0x220
  ? asm_exc_general_protection+0x22/0x30
  ? kobject_namespace+0x71/0x150
  kobject_add_internal+0x267/0x870
  kobject_add+0x120/0x1f0
  ? kset_create_and_add+0x160/0x160
  ? __kmem_cache_alloc_node+0x1d2/0x350
  ? _raw_spin_lock+0x87/0xe0
  ? kobject_create_and_add+0x3c/0xb0
  kobject_create_and_add+0x68/0xb0
  module_add_driver+0x260/0x350
  bus_add_driver+0x2c9/0x580
  driver_register+0x133/0x460
  kunit_run_tests+0xdb/0xef0
  ? _prb_read_valid+0x3e3/0x550
  ? _raw_spin_lock+0x87/0xe0
  ? _raw_spin_lock_bh+0xe0/0xe0
  ? __send_ipi_mask+0x1ba/0x450
  ? __pte_offset_map+0x19/0x1f0
  ? __pte_offset_map_lock+0xd6/0x1b0
  ? __kunit_test_suites_exit+0x30/0x30
  ? kvm_smp_send_call_func_ipi+0x68/0xc0
  ? do_sync_core+0x22/0x30
  ? smp_call_function_many_cond+0x1be/0xcf0
  ? __text_poke+0x890/0x890
  ? __text_poke+0x890/0x890
  ? on_each_cpu_cond_mask+0x46/0x70
  ? text_poke_bp_batch+0x413/0x570
  ? do_sync_core+0x30/0x30
  ? __jump_label_patch+0x34c/0x350
  ? mutex_unlock+0x80/0xd0
  ? __mutex_unlock_slowpath.constprop.0+0x2a0/0x2a0
  __kunit_test_suites_init+0xc4/0x120
  kunit_module_notify+0x36c/0x3b0
  ? __kunit_test_suites_init+0x120/0x120
  ? preempt_count_add+0x79/0x150
  notifier_call_chain+0xbf/0x280
  ? kasan_quarantine_put+0x21/0x1a0
  blocking_notifier_call_chain_robust+0xbb/0x140
  ? notifier_call_chain+0x280/0x280
  ? 0xffffffffa0238000
  load_module+0x4af0/0x67d0
  ? module_frob_arch_sections+0x20/0x20
  ? rwsem_down_write_slowpath+0x11a0/0x11a0
  ? kernel_read_file+0x3ca/0x510
  ? __x64_sys_fspick+0x2a0/0x2a0
  ? init_module_from_file+0xd2/0x130
  init_module_from_file+0xd2/0x130
  ? __ia32_sys_init_module+0xa0/0xa0
  ? userfaultfd_unmap_prep+0x3d0/0x3d0
  ? _raw_spin_lock_bh+0xe0/0xe0
  idempotent_init_module+0x339/0x610
  ? init_module_from_file+0x130/0x130
  ? __fget_light+0x57/0x500
  __x64_sys_finit_module+0xba/0x130
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Reported-by: Marco Pagani <marpagan@redhat.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/test.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 145f70219f46..8fac4783c676 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -739,7 +739,6 @@ static int kunit_module_init(struct module *mod)
 	struct kunit_suite_set suite_set = {
 		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
 	};
-	const char *action = kunit_action();
 	int err = 0;
 
 	suite_set = kunit_filter_suites(&suite_set,
@@ -752,16 +751,28 @@ static int kunit_module_init(struct module *mod)
 	mod->kunit_suites = (struct kunit_suite **)suite_set.start;
 	mod->num_kunit_suites = suite_set.end - suite_set.start;
 
-	if (!action)
+	return err;
+}
+
+static void kunit_module_exec(struct module *mod)
+{
+	struct kunit_suite_set suite_set = {
+		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
+	};
+	const char *action = kunit_action();
+
+	if (!action) {
 		kunit_exec_run_tests(&suite_set, false);
+
+		__kunit_test_suites_exit(mod->kunit_suites,
+					 mod->num_kunit_suites);
+	}
 	else if (!strcmp(action, "list"))
 		kunit_exec_list_tests(&suite_set, false);
 	else if (!strcmp(action, "list_attr"))
 		kunit_exec_list_tests(&suite_set, true);
 	else
 		pr_err("kunit: unknown action '%s'\n", action);
-
-	return err;
 }
 
 static void kunit_module_exit(struct module *mod)
@@ -769,11 +780,6 @@ static void kunit_module_exit(struct module *mod)
 	struct kunit_suite_set suite_set = {
 		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
 	};
-	const char *action = kunit_action();
-
-	if (!action)
-		__kunit_test_suites_exit(mod->kunit_suites,
-					 mod->num_kunit_suites);
 
 	kunit_free_suite_set(suite_set);
 }
@@ -789,6 +795,7 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 		ret = kunit_module_init(mod);
 		break;
 	case MODULE_STATE_LIVE:
+		kunit_module_exec(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
-- 
2.34.1

