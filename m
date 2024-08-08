Return-Path: <linux-kselftest+bounces-15030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DF94BDC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8449AB227B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03E18CBEE;
	Thu,  8 Aug 2024 12:42:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09018C357;
	Thu,  8 Aug 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120977; cv=none; b=ebBR9/q9kFmdHm0ZJlWfaGdEtLcI2X/EPGBYKZqrgvs438ZOVM5cFk+jjY6L8SXT4dCj33R37T/a+MyW/5qtr6aSpM8rbhtmCpfcPYRqC/LAI5o4PY1ZP2nPEtW++dEnn7HQguR1dmC1Bl/pZTwfQ5TVs0aeWcH2mm78Gs7EQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120977; c=relaxed/simple;
	bh=ru9hgd1BVGxo/YtGYhYFbme4Oi99DGqI5rek/Z89kb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4KxZb8tA4EC3umDkXZ8+DURHcF7Li0PgtzodiF4VRnnsEBmRiVvYXeTAxQ9rrqIABB/ZrEpAJc43cnCaW0ULJ25Fc2nmEKlX78jdd2/7j6dodhXlrqnGr20/azIQcuBq6DzkpYeKboowyg8V0x3LwJOoP7BmmOhNE3T6yI2+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfmrN2xdNzpStK;
	Thu,  8 Aug 2024 20:41:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C4161402CC;
	Thu,  8 Aug 2024 20:42:52 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:42:51 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v13 01/14] mm: page_frag: add a test module for page_frag
Date: Thu, 8 Aug 2024 20:37:01 +0800
Message-ID: <20240808123714.462740-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

The testing is done by ensuring that the fragment allocated
from a frag_frag_cache instance is pushed into a ptr_ring
instance in a kthread binded to a specified cpu, and a kthread
binded to a specified cpu will pop the fragment from the
ptr_ring and free the fragment.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/page_frag/Makefile |  18 ++
 .../selftests/mm/page_frag/page_frag_test.c   | 170 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   9 +-
 4 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
 create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 901e0d07765b..e91ed29378fc 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -36,6 +36,8 @@ MAKEFLAGS += --no-builtin-rules
 CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+TEST_GEN_MODS_DIR := page_frag
+
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_longterm
diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
new file mode 100644
index 000000000000..58dda74d50a3
--- /dev/null
+++ b/tools/testing/selftests/mm/page_frag/Makefile
@@ -0,0 +1,18 @@
+PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = page_frag_test.ko
+
+obj-m += page_frag_test.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) clean
diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
new file mode 100644
index 000000000000..0e803db1ad79
--- /dev/null
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for page_frag cache
+ *
+ * Copyright: linyunsheng@huawei.com
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/ptr_ring.h>
+#include <linux/kthread.h>
+
+static struct ptr_ring ptr_ring;
+static int nr_objs = 512;
+static atomic_t nthreads;
+static struct completion wait;
+static struct page_frag_cache test_frag;
+
+static int nr_test = 5120000;
+module_param(nr_test, int, 0);
+MODULE_PARM_DESC(nr_test, "number of iterations to test");
+
+static bool test_align;
+module_param(test_align, bool, 0);
+MODULE_PARM_DESC(test_align, "use align API for testing");
+
+static int test_alloc_len = 2048;
+module_param(test_alloc_len, int, 0);
+MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
+
+static int test_push_cpu;
+module_param(test_push_cpu, int, 0);
+MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
+
+static int test_pop_cpu;
+module_param(test_pop_cpu, int, 0);
+MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
+
+static int page_frag_pop_thread(void *arg)
+{
+	struct ptr_ring *ring = arg;
+	int nr = nr_test;
+
+	pr_info("page_frag pop test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (nr > 0) {
+		void *obj = __ptr_ring_consume(ring);
+
+		if (obj) {
+			nr--;
+			page_frag_free(obj);
+		} else {
+			cond_resched();
+		}
+	}
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	pr_info("page_frag pop test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	return 0;
+}
+
+static int page_frag_push_thread(void *arg)
+{
+	struct ptr_ring *ring = arg;
+	int nr = nr_test;
+
+	pr_info("page_frag push test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (nr > 0) {
+		void *va;
+		int ret;
+
+		if (test_align) {
+			va = page_frag_alloc_align(&test_frag, test_alloc_len,
+						   GFP_KERNEL, SMP_CACHE_BYTES);
+
+			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
+				  "unaligned va returned\n");
+		} else {
+			va = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);
+		}
+
+		if (!va)
+			continue;
+
+		ret = __ptr_ring_produce(ring, va);
+		if (ret) {
+			page_frag_free(va);
+			cond_resched();
+		} else {
+			nr--;
+		}
+	}
+
+	pr_info("page_frag push test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	return 0;
+}
+
+static int __init page_frag_test_init(void)
+{
+	struct task_struct *tsk_push, *tsk_pop;
+	ktime_t start;
+	u64 duration;
+	int ret;
+
+	test_frag.va = NULL;
+	atomic_set(&nthreads, 2);
+	init_completion(&wait);
+
+	if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0 ||
+	    !cpu_active(test_push_cpu) || !cpu_active(test_pop_cpu))
+		return -EINVAL;
+
+	ret = ptr_ring_init(&ptr_ring, nr_objs, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_ring,
+					 test_push_cpu, "page_frag_push");
+	if (IS_ERR(tsk_push))
+		return PTR_ERR(tsk_push);
+
+	tsk_pop = kthread_create_on_cpu(page_frag_pop_thread, &ptr_ring,
+					test_pop_cpu, "page_frag_pop");
+	if (IS_ERR(tsk_pop)) {
+		kthread_stop(tsk_push);
+		return PTR_ERR(tsk_pop);
+	}
+
+	start = ktime_get();
+	wake_up_process(tsk_push);
+	wake_up_process(tsk_pop);
+
+	pr_info("waiting for test to complete\n");
+	wait_for_completion(&wait);
+
+	duration = (u64)ktime_us_delta(ktime_get(), start);
+	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
+		test_align ? "aligned" : "non-aligned", duration);
+
+	ptr_ring_cleanup(&ptr_ring, NULL);
+	page_frag_cache_drain(&test_frag);
+
+	return -EAGAIN;
+}
+
+static void __exit page_frag_test_exit(void)
+{
+}
+
+module_init(page_frag_test_init);
+module_exit(page_frag_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yunsheng Lin <linyunsheng@huawei.com>");
+MODULE_DESCRIPTION("Test module for page_frag");
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 03ac4f2e1cce..3636d984b786 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -75,6 +75,8 @@ separated by spaces:
 	read-only VMAs
 - mdwe
 	test prctl(PR_SET_MDWE, ...)
+- page_frag
+	test handling of page fragment allocation and freeing
 
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
@@ -231,7 +233,8 @@ run_test() {
 		("$@" 2>&1) | tap_prefix
 		local ret=${PIPESTATUS[0]}
 		count_total=$(( count_total + 1 ))
-		if [ $ret -eq 0 ]; then
+		# page_frag_test.ko returns 11(EAGAIN) when insmod'ing to avoid rmmod
+		if [ $ret -eq 0 ] | [ $ret -eq 11 -a ${CATEGORY} == "page_frag" ]; then
 			count_pass=$(( count_pass + 1 ))
 			echo "[PASS]" | tap_prefix
 			echo "ok ${count_total} ${test}" | tap_output
@@ -453,6 +456,10 @@ CATEGORY="mkdirty" run_test ./mkdirty
 
 CATEGORY="mdwe" run_test ./mdwe_test
 
+CATEGORY="page_frag" run_test insmod ./page_frag/page_frag_test.ko
+
+CATEGORY="page_frag" run_test insmod ./page_frag/page_frag_test.ko test_alloc_len=12 test_align=1
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
-- 
2.33.0


