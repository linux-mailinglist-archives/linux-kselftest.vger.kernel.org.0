Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09952A25E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgKBILf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 03:11:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6726 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgKBILA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 03:11:00 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPlwY02r0zkdXb;
        Mon,  2 Nov 2020 16:10:53 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.65) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 16:10:46 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <robin.murphy@arm.com>, <m.szyprowski@samsung.com>
CC:     <linuxarm@huawei.com>, <linux-kselftest@vger.kernel.org>,
        <xuwei5@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 2/2] selftests/dma: add test application for DMA_MAP_BENCHMARK
Date:   Mon, 2 Nov 2020 21:06:46 +1300
Message-ID: <20201102080646.2180-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.65]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch provides the test application for DMA_MAP_BENCHMARK.

Before running the test application, we need to bind a device to dma_map_
benchmark driver. For example, unbind "xxx" from its original driver and
bind to dma_map_benchmark:

echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
echo xxx > /sys/bus/platform/drivers/xxx/unbind
echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind

Another example for PCI devices:
echo dma_map_benchmark > /sys/bus/pci/devices/0000:00:01.0/driver_override
echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind
echo 0000:00:01.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind

The below command will run 16 threads on numa node 0 for 10 seconds on
the device bound to dma_map_benchmark platform_driver or pci_driver:
./dma_map_benchmark -t 16 -s 10 -n 0
dma mapping benchmark: threads:16 seconds:10
average map latency(us):1.1 standard deviation:1.9
average unmap latency(us):0.5 standard deviation:0.8

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 MAINTAINERS                                   |  6 ++
 tools/testing/selftests/dma/Makefile          |  6 ++
 tools/testing/selftests/dma/config            |  1 +
 .../testing/selftests/dma/dma_map_benchmark.c | 87 +++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 608fc8484c02..a1e38d5e14f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5247,6 +5247,12 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
 F:	kernel/dma/
 
+DMA MAPPING BENCHMARK
+M:	Barry Song <song.bao.hua@hisilicon.com>
+L:	iommu@lists.linux-foundation.org
+F:	kernel/dma/map_benchmark.c
+F:	tools/testing/selftests/dma/
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
new file mode 100644
index 000000000000..aa8e8b5b3864
--- /dev/null
+++ b/tools/testing/selftests/dma/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -I../../../../usr/include/
+
+TEST_GEN_PROGS := dma_map_benchmark
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dma/config b/tools/testing/selftests/dma/config
new file mode 100644
index 000000000000..6102ee3c43cd
--- /dev/null
+++ b/tools/testing/selftests/dma/config
@@ -0,0 +1 @@
+CONFIG_DMA_MAP_BENCHMARK=y
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
new file mode 100644
index 000000000000..4778df0c458f
--- /dev/null
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Hisilicon Limited.
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/types.h>
+
+#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_MAX_THREADS	1024
+#define DMA_MAP_MAX_SECONDS     300
+
+struct map_benchmark {
+	__u64 avg_map_100ns; /* average map latency in 100ns */
+	__u64 map_stddev; /* standard deviation of map latency */
+	__u64 avg_unmap_100ns; /* as above */
+	__u64 unmap_stddev;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	int node; /* which numa node this benchmark will run on */
+	__u64 expansion[10];	/* For future use */
+};
+
+int main(int argc, char **argv)
+{
+	struct map_benchmark map;
+	int fd, opt;
+	/* default single thread, run 20 seconds on NUMA_NO_NODE */
+	int threads = 1, seconds = 20, node = -1;
+	int cmd = DMA_MAP_BENCHMARK;
+	char *p;
+
+	while ((opt = getopt(argc, argv, "t:s:n:")) != -1) {
+		switch (opt) {
+		case 't':
+			threads = atoi(optarg);
+			break;
+		case 's':
+			seconds = atoi(optarg);
+			break;
+		case 'n':
+			node = atoi(optarg);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
+		fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
+			DMA_MAP_MAX_THREADS);
+		exit(1);
+	}
+
+	if (seconds <= 0 || seconds > DMA_MAP_MAX_SECONDS) {
+		fprintf(stderr, "invalid number of seconds, must be in 1-%d\n",
+			DMA_MAP_MAX_SECONDS);
+		exit(1);
+	}
+
+	fd = open("/sys/kernel/debug/dma_map_benchmark", O_RDWR);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	map.seconds = seconds;
+	map.threads = threads;
+	map.node = node;
+	if (ioctl(fd, cmd, &map)) {
+		perror("ioctl");
+		exit(1);
+	}
+
+	printf("dma mapping benchmark: threads:%d seconds:%d\n", threads, seconds);
+	printf("average map latency(us):%.1f standard deviation:%.1f\n",
+			map.avg_map_100ns/10.0, map.map_stddev/10.0);
+	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
+			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
+
+	return 0;
+}
-- 
2.25.1

