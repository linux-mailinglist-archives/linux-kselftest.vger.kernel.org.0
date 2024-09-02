Return-Path: <linux-kselftest+bounces-16963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E4968725
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32461F2448E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A8201244;
	Mon,  2 Sep 2024 12:09:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA05200108;
	Mon,  2 Sep 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278951; cv=none; b=S5PGZtYFK+998pSmh8fxfhNXbS3GS4V11nz4X+pyGsG/6RvCz8L+JtNt3eoaFKBuJ+RsLySKqUfgJINrpjHpc1H2gLqam32CN6hRDJQ9Q4YDxSCCj4dqD3tgkGdc/uZbL/LBxgYap9R3W9Lfr3fXQHbV87oAdybERfF27+rARJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278951; c=relaxed/simple;
	bh=uvRMweJAaeBgY9UfSQPn1Zsgkg3qkJBjgpOSYukJuDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMSXFXRspedaelHBf5Eg/74jmINITqGSQYN05xgnIaU22CyF146b3VRVX1CAzGm6CQkyHu7neMSwfBOP76PXGhHcsYoetLugSmmAUYlcPMo2dtBS1zWISEVCzaLmDrn0NrCUpalABnhwEcIHF3E9wK6sgjj4AzQ4dXWxry0nCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wy6qZ2Ltvz69Mp;
	Mon,  2 Sep 2024 20:04:10 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AE9CD18007C;
	Mon,  2 Sep 2024 20:09:05 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:05 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v17 01/14] mm: page_frag: add a test module for page_frag
Date: Mon, 2 Sep 2024 20:03:00 +0800
Message-ID: <20240902120314.508180-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240902120314.508180-1-linyunsheng@huawei.com>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
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
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/page_frag/Makefile |  18 ++
 .../selftests/mm/page_frag/page_frag_test.c   | 170 +++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   8 +
 tools/testing/selftests/mm/test_page_frag.sh  | 171 ++++++++++++++++++
 5 files changed, 370 insertions(+)
 create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
 create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
 create mode 100755 tools/testing/selftests/mm/test_page_frag.sh

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index cfad627e8d94..e98ec779b2aa 100644
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
@@ -125,6 +127,7 @@ TEST_FILES += test_hmm.sh
 TEST_FILES += va_high_addr_switch.sh
 TEST_FILES += charge_reserved_hugetlb.sh
 TEST_FILES += hugetlb_reparenting_test.sh
+TEST_FILES += test_page_frag.sh
 
 # required by charge_reserved_hugetlb.sh
 TEST_FILES += write_hugetlb_memory.sh
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
index 000000000000..6d6f31936b10
--- /dev/null
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for page_frag cache
+ *
+ * Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
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
+static struct page_frag_cache test_nc;
+
+static int nr_test = 2000000;
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
+			va = page_frag_alloc_align(&test_nc, test_alloc_len,
+						   GFP_KERNEL, SMP_CACHE_BYTES);
+
+			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
+				  "unaligned va returned\n");
+		} else {
+			va = page_frag_alloc(&test_nc, test_alloc_len, GFP_KERNEL);
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
+	test_nc.va = NULL;
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
+	page_frag_cache_drain(&test_nc);
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
index 36045edb10de..96fd470b9f51 100755
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
@@ -456,6 +458,12 @@ CATEGORY="mkdirty" run_test ./mkdirty
 
 CATEGORY="mdwe" run_test ./mdwe_test
 
+CATEGORY="page_frag" run_test ./test_page_frag.sh smoke
+
+CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
+
+CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
diff --git a/tools/testing/selftests/mm/test_page_frag.sh b/tools/testing/selftests/mm/test_page_frag.sh
new file mode 100755
index 000000000000..d2b0734a90b5
--- /dev/null
+++ b/tools/testing/selftests/mm/test_page_frag.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to test the
+# correctness and performance of page_frag's implementation.
+# Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of page fragment allocations;
+#     b) stressing and stability check of page_frag subsystem.
+
+DRIVER="./page_frag/page_frag_test.ko"
+CPU_LIST=$(grep -m 2 processor /proc/cpuinfo | cut -d ' ' -f 2)
+TEST_CPU_0=$(echo $CPU_LIST | awk '{print $1}')
+
+if [ $(echo $CPU_LIST | wc -w) -gt 1 ]; then
+	TEST_CPU_1=$(echo $CPU_LIST | awk '{print $2}')
+	NR_TEST=100000000
+else
+	TEST_CPU_1=$TEST_CPU_0
+	NR_TEST=1000000
+fi
+
+# 1 if fails
+exitcode=1
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+#
+# Static templates for testing of page_frag APIs.
+# Also it is possible to pass any supported parameters manually.
+#
+SMOKE_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_1"
+NONALIGNED_PARAM="$SMOKE_PARAM test_alloc_len=75 nr_test=$NR_TEST"
+ALIGNED_PARAM="$NONALIGNED_PARAM test_align=1"
+
+check_test_requirements()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which insmod > /dev/null 2>&1; then
+		echo "$0: You need insmod installed"
+		exit $ksft_skip
+	fi
+
+	if [ ! -f $DRIVER ]; then
+		echo "$0: You need to compile page_frag_test module"
+		exit $ksft_skip
+	fi
+}
+
+run_nonaligned_check()
+{
+	echo "Run performance tests to evaluate how fast nonaligned alloc API is."
+
+	insmod $DRIVER $NONALIGNED_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Ccheck the kernel ring buffer to see the summary."
+}
+
+run_aligned_check()
+{
+	echo "Run performance tests to evaluate how fast aligned alloc API is."
+
+	insmod $DRIVER $ALIGNED_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_smoke_check()
+{
+	echo "Run smoke test."
+
+	insmod $DRIVER $SMOKE_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+usage()
+{
+	echo -n "Usage: $0 [ aligned ] | [ nonaligned ] | | [ smoke ] | "
+	echo "manual parameters"
+	echo
+	echo "Valid tests and parameters:"
+	echo
+	modinfo $DRIVER
+	echo
+	echo "Example usage:"
+	echo
+	echo "# Shows help message"
+	echo "$0"
+	echo
+	echo "# Smoke testing"
+	echo "$0 smoke"
+	echo
+	echo "# Performance testing for nonaligned alloc API"
+	echo "$0 nonaligned"
+	echo
+	echo "# Performance testing for aligned alloc API"
+	echo "$0 aligned"
+	echo
+	exit 0
+}
+
+function validate_passed_args()
+{
+	VALID_ARGS=`modinfo $DRIVER | awk '/parm:/ {print $2}' | sed 's/:.*//'`
+
+	#
+	# Something has been passed, check it.
+	#
+	for passed_arg in $@; do
+		key=${passed_arg//=*/}
+		valid=0
+
+		for valid_arg in $VALID_ARGS; do
+			if [[ $key = $valid_arg ]]; then
+				valid=1
+				break
+			fi
+		done
+
+		if [[ $valid -ne 1 ]]; then
+			echo "Error: key is not correct: ${key}"
+			exit $exitcode
+		fi
+	done
+}
+
+function run_manual_check()
+{
+	#
+	# Validate passed parameters. If there is wrong one,
+	# the script exists and does not execute further.
+	#
+	validate_passed_args $@
+
+	echo "Run the test with following parameters: $@"
+	insmod $DRIVER $@ > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+function run_test()
+{
+	if [ $# -eq 0 ]; then
+		usage
+	else
+		if [[ "$1" = "smoke" ]]; then
+			run_smoke_check
+		elif [[ "$1" = "nonaligned" ]]; then
+			run_nonaligned_check
+		elif [[ "$1" = "aligned" ]]; then
+			run_aligned_check
+		else
+			run_manual_check $@
+		fi
+	fi
+}
+
+check_test_requirements
+run_test $@
+
+exit 0
-- 
2.33.0


