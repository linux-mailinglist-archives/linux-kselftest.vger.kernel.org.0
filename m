Return-Path: <linux-kselftest+bounces-17514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA76971365
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D22850DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE771B3739;
	Mon,  9 Sep 2024 09:25:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B442AAB;
	Mon,  9 Sep 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873913; cv=none; b=FYMHhcJxDg7QWHQRO7OuNNnXmJs2H8A+3ku9seVeVzLm1D2/X6LDPiuaUArgVF3OO4mrNVPIgTK+FubE3iP7xbyQQJ5FRwHOZGJ7n1N5p4tY0VwWzicThRtG0DmLlkJaNYmyJTWqRZrC+0FArKr5MUhMavnRU5m/O9wC1XtS7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873913; c=relaxed/simple;
	bh=BT1NoNWF9yuW3Sr5ezjTm+3tRzMiZcwaQqg/0frV74o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EAs/Ko/oSr9PSHWCl1H5n+jsoyuKakWYiF1YArodD32N28AAW+P1G6wOg1Y9vWADhpYqNGIMKf2j+DX4JhcOqaCBmG256cHr1TAfJYpu43AHMLCudKwUW/cg4nwLzcDW1Tbyp8ucrbeQdoDfh7sMN15GXc5jUiyKdZfnuVU+9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2LyK2mrfz2Dbvt;
	Mon,  9 Sep 2024 17:24:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 14560180044;
	Mon,  9 Sep 2024 17:25:08 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 17:25:07 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <almasrymina@google.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next] page_pool: add a test module for page_pool
Date: Mon, 9 Sep 2024 17:19:11 +0800
Message-ID: <20240909091913.987826-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

The testing is done by ensuring that the page allocated from
the page_pool instance is pushed into a ptr_ring instance in
a kthread/napi binded to a specified cpu, and a kthread/napi
binded to a specified cpu will pop the page from the ptr_ring
and free it back to the page_pool.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 tools/testing/selftests/net/Makefile          |   3 +
 .../testing/selftests/net/page_pool/Makefile  |  18 +
 .../selftests/net/page_pool/page_pool_test.c  | 433 ++++++++++++++++++
 tools/testing/selftests/net/test_page_pool.sh | 175 +++++++
 4 files changed, 629 insertions(+)
 create mode 100644 tools/testing/selftests/net/page_pool/Makefile
 create mode 100644 tools/testing/selftests/net/page_pool/page_pool_test.c
 create mode 100755 tools/testing/selftests/net/test_page_pool.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 27362e40eb37..4d4ddd853ef8 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
 
+TEST_GEN_MODS_DIR := page_pool
+
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
@@ -96,6 +98,7 @@ TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
+TEST_PROGS += test_page_pool.sh
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
diff --git a/tools/testing/selftests/net/page_pool/Makefile b/tools/testing/selftests/net/page_pool/Makefile
new file mode 100644
index 000000000000..4380a70d6391
--- /dev/null
+++ b/tools/testing/selftests/net/page_pool/Makefile
@@ -0,0 +1,18 @@
+PAGE_POOL_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(PAGE_POOL_TEST_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = page_pool_test.ko
+
+obj-m += page_pool_test.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(PAGE_POOL_TEST_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(PAGE_POOL_TEST_DIR) clean
diff --git a/tools/testing/selftests/net/page_pool/page_pool_test.c b/tools/testing/selftests/net/page_pool/page_pool_test.c
new file mode 100644
index 000000000000..475b64f21b78
--- /dev/null
+++ b/tools/testing/selftests/net/page_pool/page_pool_test.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test module for page_pool
+ *
+ * Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
+ */
+
+#include <linux/module.h>
+#include <linux/cpumask.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/etherdevice.h>
+#include <linux/ptr_ring.h>
+#include <linux/kthread.h>
+#include <net/page_pool/helpers.h>
+
+static struct ptr_ring ptr_ring;
+static int nr_objs = 512;
+static atomic_t nthreads;
+static struct completion wait;
+static struct page_pool *test_pool;
+static struct device *dev;
+static u64 dma_mask = DMA_BIT_MASK(64);
+
+static int nr_test = 2000000;
+module_param(nr_test, int, 0);
+MODULE_PARM_DESC(nr_test, "number of iterations to test");
+
+static bool test_frag;
+module_param(test_frag, bool, 0);
+MODULE_PARM_DESC(test_frag, "use frag API for testing");
+
+static bool test_dma;
+module_param(test_dma, bool, 0);
+MODULE_PARM_DESC(test_dma, "enable dma mapping for testing");
+
+static bool test_napi;
+module_param(test_napi, bool, 0);
+MODULE_PARM_DESC(test_napi, "use NAPI softirq for testing");
+
+static bool test_direct;
+module_param(test_direct, bool, 0);
+MODULE_PARM_DESC(test_direct, "enable direct recycle for testing");
+
+static int test_alloc_len = 2048;
+module_param(test_alloc_len, int, 0);
+MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
+
+static int test_push_cpu;
+module_param(test_push_cpu, int, 0);
+MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing page");
+
+static int test_pop_cpu;
+module_param(test_pop_cpu, int, 0);
+MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping page");
+
+static void page_pool_test_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static struct page_pool *page_pool_test_create(void)
+{
+	struct page_pool_params page_pool_params = {
+		.pool_size = nr_objs,
+		.flags = 0,
+		.nid = cpu_to_mem(test_push_cpu),
+	};
+	int ret;
+
+	if (test_dma) {
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			return ERR_PTR(-ENOMEM);
+
+		dev->release = page_pool_test_dev_release;
+		dev->dma_mask = &dma_mask;
+		device_initialize(dev);
+
+		ret = dev_set_name(dev, "page_pool_dev");
+		if (ret) {
+			pr_err("page_pool_test dev_set_name() failed: %d\n",
+			       ret);
+			goto err_out;
+		}
+
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+		if (ret) {
+			pr_err("page_pool_test set dma mask failed: %d\n",
+			       ret);
+			goto err_out;
+		}
+
+		ret = device_add(dev);
+		if (ret) {
+			pr_err("page_pool_test device_add() failed: %d\n", ret);
+			goto err_out;
+		}
+
+		page_pool_params.dev = dev;
+		page_pool_params.flags |= PP_FLAG_DMA_MAP;
+		page_pool_params.dma_dir = DMA_FROM_DEVICE;
+	}
+
+	return page_pool_create(&page_pool_params);
+err_out:
+	put_device(dev);
+	return ERR_PTR(ret);
+}
+
+static void page_pool_test_destroy(struct page_pool *pool)
+{
+	page_pool_destroy(pool);
+
+	if (test_dma) {
+		device_del(dev);
+		put_device(dev);
+	}
+}
+
+static int test_pushed;
+static int test_popped;
+static int page_pool_pop_thread(void *arg)
+{
+	struct ptr_ring *ring = arg;
+
+	pr_info("page_pool pop test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (test_popped < nr_test) {
+		void *obj = __ptr_ring_consume(ring);
+
+		if (obj) {
+			test_popped++;
+			page_pool_put_full_page(test_pool, obj, false);
+		} else {
+			cond_resched();
+		}
+	}
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	pr_info("page_pool pop test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	return 0;
+}
+
+static int page_pool_push_thread(void *arg)
+{
+	struct ptr_ring *ring = arg;
+
+	pr_info("page_pool push test thread begins on cpu %d\n",
+		smp_processor_id());
+
+	while (test_pushed < nr_test) {
+		struct page *page;
+		int ret;
+
+		if (test_frag) {
+			unsigned int offset;
+
+			page = page_pool_dev_alloc_frag(test_pool, &offset,
+							test_alloc_len);
+		} else {
+			page = page_pool_dev_alloc_pages(test_pool);
+		}
+
+		if (!page)
+			continue;
+
+		ret = __ptr_ring_produce(ring, page);
+		if (ret) {
+			page_pool_put_full_page(test_pool, page, true);
+			cond_resched();
+		} else {
+			test_pushed++;
+		}
+	}
+
+	pr_info("page_pool push test thread exits on cpu %d\n",
+		smp_processor_id());
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	return 0;
+}
+
+static int page_pool_push_poll(struct napi_struct *napi, int budget)
+{
+	static bool print = true;
+	int processed = 0;
+
+	if (unlikely(print)) {
+		pr_info("page_pool push test napi begins on cpu %d\n",
+			smp_processor_id());
+		print = false;
+	}
+
+	while (processed < budget && test_pushed < nr_test) {
+		struct page *page;
+		int ret;
+
+		if (test_frag) {
+			unsigned int offset;
+
+			page = page_pool_dev_alloc_frag(test_pool, &offset,
+							test_alloc_len);
+		} else {
+			page = page_pool_dev_alloc_pages(test_pool);
+		}
+
+		if (!page)
+			return budget;
+
+		ret = __ptr_ring_produce(&ptr_ring, page);
+		if (ret) {
+			page_pool_put_full_page(test_pool, page, true);
+			return budget;
+		}
+
+		processed++;
+		test_pushed++;
+	}
+
+	if (test_pushed < nr_test)
+		return budget;
+
+	pr_info("page_pool push test napi exits on cpu %d\n",
+		smp_processor_id());
+
+	napi_complete(napi);
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	return 0;
+}
+
+static int page_pool_pop_poll(struct napi_struct *napi, int budget)
+{
+	static bool print = true;
+	int processed = 0;
+
+	if (unlikely(print)) {
+		pr_info("page_pool pop test napi begins on cpu %d\n",
+			smp_processor_id());
+		print = false;
+	}
+
+	while (processed < budget && test_popped < nr_test) {
+		void *obj = __ptr_ring_consume(&ptr_ring);
+
+		if (obj) {
+			processed++;
+			test_popped++;
+			page_pool_put_full_page(test_pool, obj, test_direct);
+		} else {
+			return budget;
+		}
+	}
+
+	if (test_popped < nr_test)
+		return budget;
+
+	if (atomic_dec_and_test(&nthreads))
+		complete(&wait);
+
+	napi_complete(napi);
+	pr_info("page_pool pop test napi exits on cpu %d\n",
+		smp_processor_id());
+
+	return 0;
+}
+
+static int page_pool_create_test_thread(void)
+{
+	struct task_struct *tsk_push, *tsk_pop;
+
+	tsk_push = kthread_create_on_cpu(page_pool_push_thread, &ptr_ring,
+					 test_push_cpu, "page_pool_push");
+	if (IS_ERR(tsk_push))
+		return PTR_ERR(tsk_push);
+
+	tsk_pop = kthread_create_on_cpu(page_pool_pop_thread, &ptr_ring,
+					test_pop_cpu, "page_pool_pop");
+	if (IS_ERR(tsk_pop)) {
+		kthread_stop(tsk_push);
+		return PTR_ERR(tsk_pop);
+	}
+
+	wake_up_process(tsk_push);
+	wake_up_process(tsk_pop);
+
+	return 0;
+}
+
+static struct napi_struct *pop_napi, *push_napi;
+static struct net_device *netdev;
+static int page_pool_schedule_napi(void *arg)
+{
+	struct napi_struct *napi = arg;
+
+	napi_schedule_irqoff(napi);
+
+	return 0;
+}
+
+static int page_pool_create_test_napi(void)
+{
+	struct task_struct *push_tsk, *pop_tsk;
+	int ret;
+
+	netdev = alloc_etherdev(sizeof(struct napi_struct) * 2);
+	if (!netdev)
+		return -ENOMEM;
+
+	pop_napi = netdev_priv(netdev);
+	push_napi = pop_napi + 1;
+
+	netif_napi_add(netdev, push_napi, page_pool_push_poll);
+	netif_napi_add(netdev, pop_napi, page_pool_pop_poll);
+
+	napi_enable(push_napi);
+	napi_enable(pop_napi);
+
+	push_tsk = kthread_create_on_cpu(page_pool_schedule_napi, push_napi,
+					 test_push_cpu, "page_pool_push_napi");
+	if (IS_ERR(push_tsk)) {
+		ret = PTR_ERR(push_tsk);
+		goto err_alloc_etherdev;
+	}
+
+	pop_tsk = kthread_create_on_cpu(page_pool_schedule_napi, pop_napi,
+					test_pop_cpu, "page_pool_pop_napi");
+	if (IS_ERR(pop_tsk)) {
+		ret = PTR_ERR(pop_tsk);
+		goto err_push_thread;
+	}
+
+	wake_up_process(push_tsk);
+	wake_up_process(pop_tsk);
+	return 0;
+
+err_push_thread:
+	kthread_stop(push_tsk);
+err_alloc_etherdev:
+	free_netdev(netdev);
+	return ret;
+}
+
+static void page_pool_destroy_test_napi(void)
+{
+	napi_disable(push_napi);
+	napi_disable(pop_napi);
+
+	netif_napi_del(push_napi);
+	netif_napi_del(pop_napi);
+
+	free_netdev(netdev);
+}
+
+static int __init page_pool_test_init(void)
+{
+	ktime_t start;
+	u64 duration;
+	int ret;
+
+	if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0 ||
+	    !cpu_active(test_push_cpu) || !cpu_active(test_pop_cpu) ||
+	    (test_direct && (test_push_cpu != test_pop_cpu || !test_napi)))
+		return -EINVAL;
+
+	ret = ptr_ring_init(&ptr_ring, nr_objs, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	test_pool = page_pool_test_create();
+	if (IS_ERR(test_pool)) {
+		ret = PTR_ERR(test_pool);
+		goto err_ptr_ring_init;
+	}
+
+	atomic_set(&nthreads, 2);
+	init_completion(&wait);
+
+	if (test_napi)
+		ret = page_pool_create_test_napi();
+	else
+		ret = page_pool_create_test_thread();
+	if (ret)
+		goto err_pool_create;
+
+	start = ktime_get();
+	pr_info("waiting for test to complete\n");
+
+	while (!wait_for_completion_timeout(&wait, msecs_to_jiffies(20000)))
+		pr_info("page_pool_test progress: pushed = %d, popped = %d\n",
+			test_pushed, test_popped);
+
+	duration = (u64)ktime_us_delta(ktime_get(), start);
+	pr_info("%d of iterations for %s%s%s%s testing took: %lluus\n",
+		nr_test, test_napi ? "napi" : "thread",
+		test_direct ? " direct" : "", test_dma ? " dma" : "",
+		test_frag ? " frag" : "", duration);
+
+	ptr_ring_cleanup(&ptr_ring, NULL);
+	page_pool_test_destroy(test_pool);
+
+	if (test_napi)
+		page_pool_destroy_test_napi();
+
+	return -EAGAIN;
+
+err_pool_create:
+	page_pool_test_destroy(test_pool);
+err_ptr_ring_init:
+	ptr_ring_cleanup(&ptr_ring, NULL);
+	return ret;
+}
+
+static void __exit page_pool_test_exit(void)
+{
+}
+
+module_init(page_pool_test_init);
+module_exit(page_pool_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yunsheng Lin <linyunsheng@huawei.com>");
+MODULE_DESCRIPTION("Test module for page_pool");
diff --git a/tools/testing/selftests/net/test_page_pool.sh b/tools/testing/selftests/net/test_page_pool.sh
new file mode 100755
index 000000000000..b9b422f5449d
--- /dev/null
+++ b/tools/testing/selftests/net/test_page_pool.sh
@@ -0,0 +1,175 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Yunsheng Lin <linyunsheng@huawei.com>
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to test the
+# correctness and performance of page_pool's implementation.
+# Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of page_pool;
+#     b) stressing and stability check of page_pool subsystem.
+
+DRIVER="./page_pool/page_pool_test.ko"
+CPU_LIST=$(grep -m 2 processor /proc/cpuinfo | cut -d ' ' -f 2)
+CPU_CNT=$(echo $CPU_LIST | wc -w)
+TEST_CPU_0=$(echo $CPU_LIST | awk '{print $1}')
+
+if [ $CPU_CNT -gt 1 ]; then
+	TEST_CPU_1=$(echo $CPU_LIST | awk '{print $2}')
+	NR_TEST=100000000
+else
+	TEST_CPU_1=$TEST_CPU_0
+	NR_TEST=1000000
+fi
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+#
+# Static templates for testing of page_pool APIs.
+# Also it is possible to pass any supported parameters manually.
+#
+SMOKE_0_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_0"
+SMOKE_1_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_1"
+NONFRAG_PARAM="$SMOKE_1_PARAM nr_test=$NR_TEST"
+FRAG_PARAM="$NONFRAG_PARAM test_alloc_len=2048 test_frag=1"
+NONFRAG_DMA_PARAM="$NONFRAG_PARAM test_dma=1"
+FRAG_DMA_PARAM="$FRAG_PARAM test_dma=1"
+NONFRAG_NAPI_PARAM="$NONFRAG_PARAM test_napi=1"
+FRAG_NAPI_PARAM="$FRAG_PARAM test_napi=1"
+NAPI_PARAM="$SMOKE_0_PARAM test_napi=1"
+NAPI_DIRECT_PARAM="$NAPI_PARAM test_direct=1"
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
+		echo "$0: You need to compile page_pool_test module"
+		exit $ksft_skip
+	fi
+}
+
+run_nonfrag_check()
+{
+	echo "Run performance tests to evaluate how fast nonaligned alloc API is."
+
+	insmod $DRIVER $NONFRAG_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_frag_check()
+{
+	echo "Run performance tests to evaluate how fast aligned alloc API is."
+
+	insmod $DRIVER $FRAG_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_nonfrag_dma_check()
+{
+	echo "Run performance tests to evaluate nonaligned alloc API with dma mapping."
+
+	insmod $DRIVER $NONFRAG_DMA_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_frag_dma_check()
+{
+	echo "Run performance tests to evaluate aligned alloc API with dma mapping."
+
+	insmod $DRIVER $FRAG_DMA_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_nonfrag_napi_check()
+{
+	echo "Run performance tests to evaluate nonaligned alloc API in NAPI testing mode."
+
+	insmod $DRIVER $NONFRAG_NAPI_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_frag_napi_check()
+{
+	echo "Run performance tests to evaluate aligned alloc API in NAPI testing mode."
+
+	insmod $DRIVER $FRAG_NAPI_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_napi_check()
+{
+	echo "Run performance in NAPI testing mode."
+
+	insmod $DRIVER $NAPI_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_napi_direct_check()
+{
+	echo "Run performance tests in NAPI and direct recycle testing mode."
+
+	insmod $DRIVER $NAPI_DIRECT_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_smoke_0_check()
+{
+	echo "Run smoke_0 test."
+
+	insmod $DRIVER $SMOKE_0_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+run_smoke_1_check()
+{
+	echo "Run smoke_1 test."
+
+	insmod $DRIVER $SMOKE_1_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
+
+function run_test()
+{
+	run_smoke_0_check
+	run_napi_check
+	run_napi_direct_check
+
+	if [ $CPU_CNT -gt 1 ]; then
+		run_smoke_1_check
+		run_nonfrag_check
+		run_frag_check
+		run_nonfrag_dma_check
+		run_frag_dma_check
+		run_nonfrag_napi_check
+		run_frag_napi_check
+	fi
+}
+
+check_test_requirements
+run_test
+
+exit 0
-- 
2.33.0


