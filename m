Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2FC680DF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjA3MpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 07:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjA3Moz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 07:44:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8628D05;
        Mon, 30 Jan 2023 04:44:53 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P57Bs3KfMzJrxn;
        Mon, 30 Jan 2023 20:43:17 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 20:44:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pbonzini@redhat.com>, <shuah@kernel.org>, <gshan@redhat.com>,
        <peterz@infradead.org>, <mathieu.desnoyers@efficios.com>
CC:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] KVM: selftests: Fix build error
Date:   Mon, 30 Jan 2023 20:44:45 +0800
Message-ID: <20230130124445.3476-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kvm selftests build fails with below info:

rseq_test.c:48:13: error: conflicting types for ‘sys_getcpu’; have ‘void(unsigned int *)’
   48 | static void sys_getcpu(unsigned *cpu)
      |             ^~~~~~~~~~
In file included from rseq_test.c:23:
../rseq/rseq.c:82:12: note: previous definition of ‘sys_getcpu’ with type ‘int(unsigned int *, unsigned int *)’
   82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
      |            ^~~~~~~~~~

commit 66d42ac73fc6 ("KVM: selftests: Make rseq compatible with glibc-2.35")
has include "../rseq/rseq.c", and commit 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
add sys_getcpu() implement, so use sys_getcpu in rseq/rseq.c to fix this.

Fixes: 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 3045fdf9bdf5..69ff39aa2991 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -41,18 +41,6 @@ static void guest_code(void)
 		GUEST_SYNC(0);
 }
 
-/*
- * We have to perform direct system call for getcpu() because it's
- * not available until glic 2.29.
- */
-static void sys_getcpu(unsigned *cpu)
-{
-	int r;
-
-	r = syscall(__NR_getcpu, cpu, NULL, NULL);
-	TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
-}
-
 static int next_cpu(int cpu)
 {
 	/*
@@ -249,7 +237,12 @@ int main(int argc, char *argv[])
 			 * across the seq_cnt reads.
 			 */
 			smp_rmb();
-			sys_getcpu(&cpu);
+			/*
+			 * We have to perform direct system call for getcpu() because it's
+			 * not available until glic 2.29.
+			 */
+			r = sys_getcpu(&cpu, NULL);
+			TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
 			rseq_cpu = rseq_current_cpu_raw();
 			smp_rmb();
 		} while (snapshot != atomic_read(&seq_cnt));
-- 
2.34.1

