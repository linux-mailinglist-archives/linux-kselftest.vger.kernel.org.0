Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE544D12F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbiCHJAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 04:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiCHJAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 04:00:24 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB083914F
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 00:59:27 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCTfQ1Ts6z1GByG;
        Tue,  8 Mar 2022 16:54:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 16:59:25 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <hch@lst.de>, <shuah@kernel.org>, <chenxiang66@hisilicon.com>,
        <skhan@linuxfoundation.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH v2] dma-mapping: benchmark: Extract a common header file for map_benchmark definition
Date:   Tue, 8 Mar 2022 16:59:10 +0800
Message-ID: <20220308085910.37358-1-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
have duplicate map_benchmark definitions, which tends to lead to
inconsistent changes to map_benchmark on both sides, extract a
common header file to avoid this problem.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2:
move map_benchmark.h in a more appropriate directory
---
 include/linux/map_benchmark.h                 | 31 +++++++++++++++++++
 kernel/dma/map_benchmark.c                    | 25 +--------------
 .../testing/selftests/dma/dma_map_benchmark.c | 25 +--------------
 3 files changed, 33 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/map_benchmark.h

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
new file mode 100644
index 000000000000..62674c83bde4
--- /dev/null
+++ b/include/linux/map_benchmark.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+
+#ifndef _KERNEL_DMA_BENCHMARK_H
+#define _KERNEL_DMA_BENCHMARK_H
+
+#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_MAX_THREADS     1024
+#define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
+
+#define DMA_MAP_BIDIRECTIONAL   0
+#define DMA_MAP_TO_DEVICE       1
+#define DMA_MAP_FROM_DEVICE     2
+
+struct map_benchmark {
+	__u64 avg_map_100ns; /* average map latency in 100ns */
+	__u64 map_stddev; /* standard deviation of map latency */
+	__u64 avg_unmap_100ns; /* as above */
+	__u64 unmap_stddev;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	__s32 node; /* which numa node this benchmark will run on */
+	__u32 dma_bits; /* DMA addressing capability */
+	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
+	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+};
+#endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 9b9af1bd6be3..0520a8f4fb1d 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -11,6 +11,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/map_benchmark.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -18,30 +19,6 @@
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
-#define DMA_MAP_MAX_THREADS	1024
-#define DMA_MAP_MAX_SECONDS	300
-#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
-
-#define DMA_MAP_BIDIRECTIONAL	0
-#define DMA_MAP_TO_DEVICE	1
-#define DMA_MAP_FROM_DEVICE	2
-
-struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
-	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76];	/* For future use */
-};
-
 struct map_benchmark_data {
 	struct map_benchmark bparam;
 	struct device *dev;
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 485dff51bad2..c3b3c09e995e 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -10,40 +10,17 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <linux/map_benchmark.h>
 #include <linux/types.h>
 
 #define NSEC_PER_MSEC	1000000L
 
-#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
-#define DMA_MAP_MAX_THREADS	1024
-#define DMA_MAP_MAX_SECONDS     300
-#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
-
-#define DMA_MAP_BIDIRECTIONAL	0
-#define DMA_MAP_TO_DEVICE	1
-#define DMA_MAP_FROM_DEVICE	2
-
 static char *directions[] = {
 	"BIDIRECTIONAL",
 	"TO_DEVICE",
 	"FROM_DEVICE",
 };
 
-struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
-	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76];	/* For future use */
-};
-
 int main(int argc, char **argv)
 {
 	struct map_benchmark map;
-- 
2.33.0

