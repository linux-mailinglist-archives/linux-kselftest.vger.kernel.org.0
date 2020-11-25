Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC72C37E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Nov 2020 05:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgKYEFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Nov 2020 23:05:06 -0500
Received: from mail.loongson.cn ([114.242.206.163]:41756 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgKYEFF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Nov 2020 23:05:05 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxitHq171fW1wWAA--.43984S2;
        Wed, 25 Nov 2020 12:04:58 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ build error under other arch.
Date:   Wed, 25 Nov 2020 12:04:57 +0800
Message-Id: <1606277097-5853-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxitHq171fW1wWAA--.43984S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fuw48Ar18AFWfCrW7urg_yoW8ur4xpa
        9xZrWq9FW8XFnYqa17ta1UZF1IkFWkAF45Ca95Jw4UZ34Dta4xJFn2yFyUKa4fWrZYqF4Y
        y34Sga1ag3WUtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6xIIjxv20xvE14v26r
        126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij
        64vIr41lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7IUY8wIDUUUUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQALC13QvMrfWgABs+
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Except arch x86, the function rseq_offset_deref_addv is not defined.
The function test_membarrier_manager_thread call rseq_offset_deref_addv
produces a build error.

The RSEQ_ARCH_HAS_OFFSET_DEREF_ADD should contain all the code
for the MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
If the other Arch implements this feature,
defined RSEQ_ARCH_HAS_OFFSET_DEREF_ADD in the header file
to ensure that this feature is available.

Following build errors:

param_test.c: In function ‘test_membarrier_worker_thread’:
param_test.c:1164:10: warning: implicit declaration of function ‘rseq_offset_deref_addv’
    ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
          ^~~~~~~~~~~~~~~~~~~~~~
/tmp/ccMj9yHJ.o: In function `test_membarrier_worker_thread':
param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
collect2: error: ld returned 1 exit status
make: *** [/selftests/rseq/param_test_benchmark] Error 1

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
---
 tools/testing/selftests/rseq/param_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 3845890..699ad5f 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1133,6 +1133,8 @@ static int set_signal_handler(void)
 	return ret;
 }
 
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 struct test_membarrier_thread_args {
 	int stop;
 	intptr_t percpu_list_ptr;
@@ -1286,8 +1288,6 @@ void *test_membarrier_manager_thread(void *arg)
 	return NULL;
 }
 
-/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
-#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 void test_membarrier(void)
 {
 	const int num_threads = opt_threads;
-- 
1.8.3.1

