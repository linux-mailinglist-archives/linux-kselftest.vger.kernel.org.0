Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637724D278F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 05:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiCIBax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 20:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiCIBat (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 20:30:49 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B8F4DF75;
        Tue,  8 Mar 2022 17:29:50 -0800 (PST)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCvd74zF7zbcCQ;
        Wed,  9 Mar 2022 09:24:59 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:29:48 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:29:47 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <brendanhiggins@google.com>, <glider@google.com>,
        <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
CC:     <wangkefeng.wang@huawei.com>, <liupeng256@huawei.com>
Subject: [PATCH 3/3] kfence: test: try to avoid test_gfpzero trigger rcu_stall
Date:   Wed, 9 Mar 2022 01:47:05 +0000
Message-ID: <20220309014705.1265861-4-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220309014705.1265861-1-liupeng256@huawei.com>
References: <20220309014705.1265861-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When CONFIG_KFENCE_DYNAMIC_OBJECTS is set to a big number, kfence
kunit-test-case test_gfpzero will eat up nearly all the CPU's
resources and rcu_stall is reported as the following log which is
cut from a physical server.

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu: 	68-....: (14422 ticks this GP) idle=6ce/1/0x4000000000000002
  softirq=592/592 fqs=7500 (t=15004 jiffies g=10677 q=20019)
  Task dump for CPU 68:
  task:kunit_try_catch state:R  running task
  stack:    0 pid: 9728 ppid:     2 flags:0x0000020a
  Call trace:
   dump_backtrace+0x0/0x1e4
   show_stack+0x20/0x2c
   sched_show_task+0x148/0x170
   ...
   rcu_sched_clock_irq+0x70/0x180
   update_process_times+0x68/0xb0
   tick_sched_handle+0x38/0x74
   ...
   gic_handle_irq+0x78/0x2c0
   el1_irq+0xb8/0x140
   kfree+0xd8/0x53c
   test_alloc+0x264/0x310 [kfence_test]
   test_gfpzero+0xf4/0x840 [kfence_test]
   kunit_try_run_case+0x48/0x20c
   kunit_generic_run_threadfn_adapter+0x28/0x34
   kthread+0x108/0x13c
   ret_from_fork+0x10/0x18

To avoid rcu_stall and unacceptable latency, a schedule point is
added to test_gfpzero.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 mm/kfence/kfence_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index caed6b4eba94..1b50f70a4c0f 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -627,6 +627,7 @@ static void test_gfpzero(struct kunit *test)
 			kunit_warn(test, "giving up ... cannot get same object back\n");
 			return;
 		}
+		cond_resched();
 	}
 
 	for (i = 0; i < size; i++)
-- 
2.18.0.huawei.25

