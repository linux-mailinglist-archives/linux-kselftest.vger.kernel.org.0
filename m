Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADA7A17A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjIOHmD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjIOHmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 03:42:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC7A1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 00:41:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rn5gY0dBwz1N7rg;
        Fri, 15 Sep 2023 15:39:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 15:41:51 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Benjamin Berg <benjamin.berg@intel.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] kunit: Fix a null-ptr-deref bug in kunit_run_case_catch_errors()
Date:   Fri, 15 Sep 2023 15:41:10 +0800
Message-ID: <20230915074110.2854382-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inject fault while probing kunit-test.ko, the below null-ptr-deref
occurs.

In kunit_run_case_catch_errors(), if the first kunit_try_catch_run()
fails in kthread_run(), the kunit_try_run_case() will not run, so the
kunit_resource_test_init() and kunit_resource_test_cases() will not
run. And if the second call of kunit_try_catch_run() succeeds, it
will call kunit_resource_test_exit(), but the test->priv is NULL, call
kunit_cleanup() will cause below null-ptr-deref.

So just return the error code if the first kunit_try_catch_run()
fails.

 BUG: KASAN: null-ptr-deref in _raw_spin_lock_irqsave+0x7e/0xe0
 Write of size 4 at addr 0000000000000054 by task kunit_try_catch/10476

 CPU: 2 PID: 10476 Comm: kunit_try_catch Tainted: G        W        N 6.6.0-rc1+ #77
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x33/0x50
  print_report+0x3e5/0x600
  ? dequeue_entity+0x3c1/0x11e0
  ? rcu_trc_cmpxchg_need_qs+0x5e/0xa0
  ? _raw_spin_lock_irqsave+0x7e/0xe0
  kasan_report+0x90/0xc0
  ? _raw_spin_lock_irqsave+0x7e/0xe0
  kasan_check_range+0xe9/0x190
  _raw_spin_lock_irqsave+0x7e/0xe0
  ? _raw_read_lock_bh+0x40/0x40
  ? _raw_spin_lock_irqsave+0x8d/0xe0
  kunit_cleanup+0x77/0x110
  kunit_resource_test_exit+0x2c/0x50 [kunit_test]
  ? __kthread_parkme+0x8b/0x160
  kunit_try_run_case_cleanup+0xac/0xe0
  ? kunit_cleanup+0x110/0x110
  kunit_generic_run_threadfn_adapter+0x4a/0x90
  ? kunit_try_catch_throw+0x80/0x80
  kthread+0x2b6/0x380
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x70
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
 ==================================================================
 Disabling lock debugging due to kernel taint
 BUG: kernel NULL pointer dereference, address: 0000000000000054
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP KASAN
 CPU: 2 PID: 10476 Comm: kunit_try_catch Tainted: G    B   W        N 6.6.0-rc1+ #77
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:_raw_spin_lock_irqsave+0x96/0xe0
 Code: 00 00 48 89 ef c7 44 24 20 00 00 00 00 e8 c2 02 88 fd be 04 00 00 00 48 8d 7c 24 20 e8 b3 02 88 fd ba 01 00 00 00 8b 44 24 20 <f0> 0f b1 55 00 75 2e 48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00
 RSP: 0018:ffff888108d07de0 EFLAGS: 00010097
 RAX: 0000000000000000 RBX: 1ffff110211a0fbc RCX: ffffffff840a0c9d
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888108d07e00
 RBP: 0000000000000054 R08: ffffed10211a0fc0 R09: ffffed10211a0fc1
 R10: ffffed10211a0fc0 R11: 0000000000000003 R12: 0000000000000246
 R13: dffffc0000000000 R14: ffff88810dbdf590 R15: 0000000000000054
 FS:  0000000000000000(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000054 CR3: 0000000107a31002 CR4: 0000000000170ee0
 DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
 DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Call Trace:
  <TASK>
  ? __die_body+0x1b/0x60
  ? page_fault_oops+0x238/0x760
  ? page_fault_oops+0x760/0x760
  ? spurious_kernel_fault+0x2d0/0x2d0
  ? search_bpf_extables+0x134/0x190
  ? fixup_exception+0x4a/0xa20
  ? do_user_addr_fault+0xaa/0x1180
  ? exc_page_fault+0x5a/0xd0
  ? asm_exc_page_fault+0x22/0x30
  ? _raw_spin_lock_irqsave+0x8d/0xe0
  ? _raw_spin_lock_irqsave+0x96/0xe0
  ? _raw_read_lock_bh+0x40/0x40
  ? _raw_spin_lock_irqsave+0x8d/0xe0
  kunit_cleanup+0x77/0x110
  kunit_resource_test_exit+0x2c/0x50 [kunit_test]
  ? __kthread_parkme+0x8b/0x160
  kunit_try_run_case_cleanup+0xac/0xe0
  ? kunit_cleanup+0x110/0x110
  kunit_generic_run_threadfn_adapter+0x4a/0x90
  ? kunit_try_catch_throw+0x80/0x80
  kthread+0x2b6/0x380
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x70
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
 Modules linked in: kunit_test(+) [last unloaded: kunit_test]
 Dumping ftrace buffer:
    (ftrace buffer empty)
 CR2: 0000000000000054
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:_raw_spin_lock_irqsave+0x96/0xe0
 Code: 00 00 48 89 ef c7 44 24 20 00 00 00 00 e8 c2 02 88 fd be 04 00 00 00 48 8d 7c 24 20 e8 b3 02 88 fd ba 01 00 00 00 8b 44 24 20 <f0> 0f b1 55 00 75 2e 48 b8 00 00 00 00 00 fc ff df 48 c7 04 03 00
 RSP: 0018:ffff888108d07de0 EFLAGS: 00010097
 RAX: 0000000000000000 RBX: 1ffff110211a0fbc RCX: ffffffff840a0c9d
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888108d07e00
 RBP: 0000000000000054 R08: ffffed10211a0fc0 R09: ffffed10211a0fc1
 R10: ffffed10211a0fc0 R11: 0000000000000003 R12: 0000000000000246
 R13: dffffc0000000000 R14: ffff88810dbdf590 R15: 0000000000000054
 FS:  0000000000000000(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000054 CR3: 0000000107a31002 CR4: 0000000000170ee0
 DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
 DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Kernel panic - not syncing: Fatal exception
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: disabled
 Rebooting in 1 seconds..

Fixes: 55e8c1b49ac5 ("kunit: Always run cleanup from a test kthread")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/kunit/try-catch.h | 2 +-
 lib/kunit/test.c          | 6 +++++-
 lib/kunit/try-catch.c     | 9 ++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
index c507dd43119d..5192b8e0aac6 100644
--- a/include/kunit/try-catch.h
+++ b/include/kunit/try-catch.h
@@ -53,7 +53,7 @@ struct kunit_try_catch {
 	void *context;
 };
 
-void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
+int kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..f20cce96a971 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -512,6 +512,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
+	int ret = 0;
 
 	try_catch = &test->try_catch;
 
@@ -522,7 +523,9 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test = test;
 	context.suite = suite;
 	context.test_case = test_case;
-	kunit_try_catch_run(try_catch, &context);
+	ret = kunit_try_catch_run(try_catch, &context);
+	if (ret)
+		goto out;
 
 	/* Now run the cleanup */
 	kunit_try_catch_init(try_catch,
@@ -531,6 +534,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 			     kunit_catch_run_case_cleanup);
 	kunit_try_catch_run(try_catch, &context);
 
+out:
 	/* Propagate the parameter result to the test case. */
 	if (test->status == KUNIT_FAILURE)
 		test_case->status = KUNIT_FAILURE;
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..b937da7ec0a4 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -55,7 +55,7 @@ static unsigned long kunit_test_timeout(void)
 	return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
 }
 
-void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
+int kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 {
 	DECLARE_COMPLETION_ONSTACK(try_completion);
 	struct kunit *test = try_catch->test;
@@ -70,7 +70,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 				  "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
 		try_catch->catch(try_catch->context);
-		return;
+		try_catch->try_result = -EINTR;
+		return PTR_ERR(task_struct);
 	}
 
 	time_remaining = wait_for_completion_timeout(&try_completion,
@@ -84,7 +85,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	exit_code = try_catch->try_result;
 
 	if (!exit_code)
-		return;
+		return 0;
 
 	if (exit_code == -EFAULT)
 		try_catch->try_result = 0;
@@ -94,5 +95,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
 
 	try_catch->catch(try_catch->context);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kunit_try_catch_run);
-- 
2.34.1

